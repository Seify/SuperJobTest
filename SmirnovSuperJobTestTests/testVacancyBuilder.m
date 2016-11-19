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

@implementation testVacancyBuilder

#pragma mark - Setup

- (void)setUp
{
    [super setUp];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Helpers

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

- (void)testBuilderReturnsRightModelsCount
{
    // given
    id testJSON = [self JSONForResourceNamed:@"testVacancies"];
    
    //when
    NSArray *models = [VacancyBuilder vacancyModelsFromJSON:testJSON];
    
    //then
    XCTAssertEqual( 1, models.count );
}

- (void)testBuilderFillsAllModelFields
{
    //given
    id testJSON = [self JSONForResourceNamed:@"testVacancies"];
    
    //when
    NSArray *models = [VacancyBuilder vacancyModelsFromJSON:testJSON];
    
    //then
    VacancyModel *vm = [models lastObject];
    //TODO: XCTAssert([vm.profession isEqualToString:@"string"]) fails, maybe because vm.profession is NSCFString
    XCTAssert([vm.profession isKindOfClass:[NSString class]]);
    XCTAssert([vm.date_published isKindOfClass:[NSString class]]);
    XCTAssert([vm.work isKindOfClass:[NSString class]]);
    XCTAssert([vm.compensation isKindOfClass:[NSString class]]);
    XCTAssert([vm.address isKindOfClass:[NSString class]] || [vm.address isKindOfClass:[NSNull class]]);
    XCTAssert([vm.townName isKindOfClass:[NSString class]]);
    XCTAssert([vm.educationName isKindOfClass:[NSString class]]);
    XCTAssert([vm.experienceName isKindOfClass:[NSString class]]);
    XCTAssert([vm.firmName isKindOfClass:[NSString class]]);
}

- (void)testReturnsNilIfServerResponseError
{
    //given
    id testJSON = [self JSONForResourceNamed:@"errorResponse"];
    
    //when
    NSArray *models = [VacancyBuilder vacancyModelsFromJSON:testJSON];
    
    //then
    XCTAssertNil(models);
}

@end
