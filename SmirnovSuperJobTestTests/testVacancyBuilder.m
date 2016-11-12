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
@property id testJSON;
@end

@implementation testVacancyBuilder

- (void)setUp
{
    [super setUp];

    NSString *pathToTestData = [[NSBundle bundleForClass:[self class]] pathForResource:@"testVacancies" ofType:nil];
    XCTAssertNotNil(pathToTestData);
    
    NSData *testVacancyResponse = [NSData dataWithContentsOfFile:pathToTestData];
    XCTAssertNotNil(testVacancyResponse);
    
    NSError *error = nil;
    self.testJSON = [NSJSONSerialization JSONObjectWithData:testVacancyResponse options:0 error:&error];
    
    XCTAssertNil(error);

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testBuilderReturnsRightModelsCount
{
    // given
    id testJSON = self.testJSON;
    
    //when
    NSArray *models = [VacancyBuilder vacancyModelsFromJSON:testJSON];
    
    //then
    XCTAssertEqual( 1, models.count );
}

- (void)testBuilderFillsAllModelFields
{
    // given
    id testJSON = self.testJSON;
    
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

@end
