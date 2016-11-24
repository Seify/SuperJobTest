//
//  testVacancyBuilder.m
//  SuperJob
//
//  Created by Roman S on 12.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "VacancyBuilder.h"

@interface testVacancyBuilder : XCTestCase
@end

@interface VacancyBuilder()
+ (NSString *)dayAndMonthStringFromDate:(NSDate *)date_published WithLocale:(NSLocale *)locale;
+ (BOOL)isDateToday:(NSDate *)date_published;
+ (NSString *)dateFromUnixtime:(int)unixtime;
+ (NSString *)paymentNameFromPaymentFrom:(NSNumber *)paymentFrom PaymentTo:(NSNumber *)paymentTo;
+ (NSString *)paymentNameFromDictionary:(NSDictionary *)objectDict;
+ (VacancyModel *)vacancyFromDictionary:(NSDictionary *)objectDict;
+ (NSError *)errorFromJSON:(id<NSObject>)JSONData;
+ (NSArray *)vacanciesFromJSON:(NSDictionary *)JSONDict;
+ (VacanciesPageModel *)pageFromJSON:(NSDictionary *)JSONDict PageID:(int)pageID Keyword:(NSString *)keyword;
@end

@implementation testVacancyBuilder

#pragma mark - Setup

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

#pragma mark - Helpers

- (NSDictionary *)testJSONWithError
{
    return @{@"error" : @{ @"message" : @"Необходима авторизация.", @"code" : @(400), @"error" : @"some_error"} };
}

- (NSDictionary *)testJSONWithoutError
{
    NSDictionary *testVacancy1 = @{@"profession" : @"учитель", @"work" : @"школа", @"date_published" : @(946123200)};
    NSDictionary *testVacancy2 = @{@"profession" : @"полицейский", @"work" : @"полиция", @"date_published" : @(333)};
    return @{@"objects" : @[testVacancy1, testVacancy2], @"more" : @(YES)};
}

- (NSDate *)date25dec1999
{
    return [NSDate dateWithTimeIntervalSince1970:(946123200)];
}

- (id)JSONForResourceNamed:(NSString *)resourceName
{
    NSString *pathToTestData = [[NSBundle bundleForClass:[self class]] pathForResource:resourceName ofType:nil];
    XCTAssertNotNil(pathToTestData);
    
    NSData *responseData = [NSData dataWithContentsOfFile:pathToTestData];
    XCTAssertNotNil(responseData);
    
    NSError *error = nil;
    id JSONObject = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
    XCTAssertNil(error);
    return JSONObject;
}

#pragma mark - Tests

- (void)testInternalReturnsGoodDayAndMonthName
{
    XCTAssertEqualObjects(@"25 дек.", [VacancyBuilder dayAndMonthStringFromDate:[self date25dec1999] WithLocale:[NSLocale localeWithLocaleIdentifier:@"ru_RU"]]);
}

- (void)testInternalReturnsYesIfDateToday
{
    XCTAssertTrue([VacancyBuilder isDateToday:[NSDate date]]);
}

- (void)testInternalReturnsNoIfDateNotToday
{
    XCTAssertFalse([VacancyBuilder isDateToday:[self date25dec1999]]);
}

- (void)testInternalReturnsTodayIfDateToday
{
    XCTAssertEqualObjects(@"Сегодня", [VacancyBuilder dateFromUnixtime:[[NSDate date] timeIntervalSince1970]]);
}

- (void)testInternalReturnsDayAndMonthIfDateNotToday
{
    NSString *dayAndMonth = [VacancyBuilder dayAndMonthStringFromDate:[self date25dec1999] WithLocale:[NSLocale currentLocale]];
    XCTAssertEqualObjects( dayAndMonth, [VacancyBuilder dateFromUnixtime:[[self date25dec1999] timeIntervalSince1970]]);
}

- (void)testInternalReturnGoodStringIfBothPaymentFromAndPaymentToExist
{
    XCTAssertEqualObjects( @"10Р - 20Р", [VacancyBuilder paymentNameFromPaymentFrom:@(10) PaymentTo:@(20)]);
}

- (void)testInternalReturnGoodStringIfOnlyPaymentFromExists
{
    XCTAssertEqualObjects( @"от 10Р", [VacancyBuilder paymentNameFromPaymentFrom:@(10) PaymentTo:nil]);
}

- (void)testInternalReturnGoodStringIfOnlyPaymentToExists
{
    XCTAssertEqualObjects( @"до 20Р", [VacancyBuilder paymentNameFromPaymentFrom:nil PaymentTo:@(20)]);
}

- (void)testInternalReturnGoodStringIfNeitherPaymentFromOrPaymentToExist
{
    XCTAssertNil( [VacancyBuilder paymentNameFromPaymentFrom:nil PaymentTo:nil]);
}

- (void)testInternalReturnAgreementStringIfExistsInDictionary
{
    //given
    NSDictionary *testJSONDict = @{@"agreement" : @(YES)};
    
    //then
    XCTAssertEqualObjects(@"По договоренности", [VacancyBuilder paymentNameFromDictionary:testJSONDict]);
};

- (void)testInternalReturnPaymentStringIfNoAgreementInDictionary
{
    //given
    NSDictionary *testJSONDict = @{@"payment_from" : @(10), @"payment_to" : @(20)};
    NSString *paymentString = [VacancyBuilder paymentNameFromPaymentFrom:@(10) PaymentTo:@(20)];
    
    //then
    XCTAssertEqualObjects(paymentString, [VacancyBuilder paymentNameFromDictionary:testJSONDict]);
}

- (void)testInternalReturnsCorrectVacancyModel
{
    //given
    NSDictionary *testVacancyDict = @{
                                      @"profession" : @"дворник",
                                      @"date_published" : @([NSDate date].timeIntervalSince1970),
                                      @"work" : @"Кремль",
                                      @"agreement" : @(YES),
                                      @"town" : @{@"title" : @"Свердловск"},
                                      @"education" : @{@"title" : @"высшее"},
                                      @"experience" : @{@"title" : @"без опыта"},
                                      @"firm_name" : @"Правительство РФ",
                                      };
    
    //when
    VacancyModel *vm = [VacancyBuilder vacancyFromDictionary:testVacancyDict];
    
    //then
    XCTAssertEqualObjects(vm.profession, @"дворник");
    XCTAssertEqualObjects(vm.date_published, @"Сегодня");
    XCTAssertEqualObjects(vm.work, @"Кремль");
    XCTAssertEqualObjects(vm.payment, @"По договоренности");
    XCTAssertEqualObjects(vm.townName, @"Свердловск");
    XCTAssertEqualObjects(vm.educationName, @"высшее");
    XCTAssertEqualObjects(vm.experienceName, @"без опыта");
    XCTAssertEqualObjects(vm.firmName, @"Правительство РФ");
}

- (void)testInternalReturnsErrorForJSONWithError
{
    XCTAssertNotNil([VacancyBuilder errorFromJSON:[self testJSONWithError]]);
}

- (void)testInternalReturnsNilForJSONWithoutError
{
    XCTAssertNil([VacancyBuilder errorFromJSON:[self testJSONWithoutError]]);
}

- (void)testInternalReturnedVacanciesCountWhenLoadVacanciesFromDictionary
{
    XCTAssert( 2 == [VacancyBuilder vacanciesFromJSON:[self testJSONWithoutError]].count );
}

- (void)testInternalReturedPageWithCorrectProperties
{
    //when
    VacanciesPageModel *page = [VacancyBuilder pageFromJSON:[self testJSONWithoutError] PageID:1 Keyword:@"директор банка"];
    
    //then
    XCTAssertNotNil(page.vacancies);
    XCTAssertEqual(page.hasMore, YES);
    XCTAssertEqual(page.pageID, 1);
    XCTAssertEqualObjects(page.keyword, @"директор банка");
}

- (void)testReturnsNilPageAndNotNilErrorOnJSONWithError
{
    //when
    NSError *error = nil;
    VacanciesPageModel *page = [VacancyBuilder pageFromJSON:[self testJSONWithError] PageID:0 Keyword:@"директор" Error:&error];
    
    //then
    XCTAssertNil(page);
    XCTAssertNotNil(error);
}

- (void)testReturnsNotNilPageAndNilErrorOnJSONWithoutError
{
    //when
    NSError *error = nil;
    VacanciesPageModel *page = [VacancyBuilder pageFromJSON:[self testJSONWithoutError] PageID:0 Keyword:@"директор" Error:&error];
    
    //then
    XCTAssertNil(error);
    XCTAssertNotNil(page);
}
@end
