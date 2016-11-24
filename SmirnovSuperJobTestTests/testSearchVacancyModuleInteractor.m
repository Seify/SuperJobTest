//
//  testSearchVacancyModuleInteractor.m
//  SuperJob
//
//  Created by Roman S on 15.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SearchVacancyModuleInteractor.h"
#import "VacancyModel.h"

@interface testSearchVacancyModuleInteractor : XCTestCase <SearchVacancyModuleInteractorOutput>
@property SearchVacancyModuleInteractor *interactor;
@end

@implementation testSearchVacancyModuleInteractor

#pragma mark - Setup

- (void)setUp
{
    [super setUp];
    self.interactor = [[SearchVacancyModuleInteractor alloc] init];
    self.interactor.output = self;
}

- (void)tearDown
{
    self.interactor = nil;
    [super tearDown];
}

#pragma mark - Tests

- (void)testNilKeywordIsBad
{
    //given
    
    //when
    
    //then
    XCTAssertFalse( [self.interactor isGoodKeyword:nil] );
}

- (void)testEmptyKeywordIsBad
{
    //given
    
    //when
    
    //then
    XCTAssertFalse( [self.interactor isGoodKeyword:@""] );
}

- (void)testNormalKeywordIsGood
{
    //given
    
    //when
    
    //then
    XCTAssertTrue( [self.interactor isGoodKeyword:@"грузчик, кладовщик"] );
}
@end
