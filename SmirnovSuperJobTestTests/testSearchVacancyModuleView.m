//
//  testSearchVacancyModuleView.m
//  SuperJob
//
//  Created by Roman S on 14.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SearchVacancyModuleView.h"

@interface testSearchVacancyModuleView : XCTestCase <SearchVacancyModuleViewOutput>
@property SearchVacancyModuleView *searchVacancyModuleView;
@property BOOL didLoadCalled;
@end

@implementation testSearchVacancyModuleView

#pragma mark - Setup

- (void)setUp
{
    [super setUp];
    self.searchVacancyModuleView = [[SearchVacancyModuleView alloc] init];
    self.searchVacancyModuleView.output = self;
}

- (void)tearDown
{
    self.searchVacancyModuleView = nil;
    self.didLoadCalled = NO;
    [super tearDown];
}

#pragma mark - SearchVacancyModuleViewOutput methods

- (void)didLoad
{
    self.didLoadCalled = YES;
};

- (void)searchPressedForEnteredKeyword:(NSString *)keyword
{
    
};

#pragma mark - Helpers

- (BOOL)waitForDidLoad:(NSTimeInterval)timeoutSecs
{
    NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:timeoutSecs];
    
    do {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:timeoutDate];
        if([timeoutDate timeIntervalSinceNow] < 0.0)
        {
            break;
        }
    } while ( !self.didLoadCalled );
    
    return self.didLoadCalled;
}

#pragma mark - Tests

- (void)testNotifiesPresenterOnLoad
{
    //given
    
    //when
    [self.searchVacancyModuleView viewDidLoad];
    
    //then
    [self waitForDidLoad:2];
    XCTAssertTrue(self.didLoadCalled);
}

- (void)testErrorMessageStringIsCorrect
{
    //given
    NSString *errorMessage = @"Empty keyword";
    
    //when
    [self.searchVacancyModuleView showErrorMessage:errorMessage];
    
    //then
    XCTAssert([errorMessage isEqualToString:self.searchVacancyModuleView.alert.message]);
}

- (void)testErrorMessageDismissal
{
    //given
    NSString *errorMessage = @"Empty keyword";
    [self.searchVacancyModuleView showErrorMessage:errorMessage];
    
    //when
    [self.searchVacancyModuleView dismissErrorMessage];
    
    //then
    XCTAssertNil(self.searchVacancyModuleView.alert);
}

@end
