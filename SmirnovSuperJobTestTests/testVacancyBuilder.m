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
    XCTAssertNotNil(vm.profession);
    XCTAssertNotNil(vm.date_published);
    XCTAssertNotNil(vm.work);
    XCTAssertNotNil(vm.compensation);
    XCTAssertNotNil(vm.address);
    XCTAssertNotNil(vm.townName);
    XCTAssertNotNil(vm.educationName);
    XCTAssertNotNil(vm.experienceName);
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
