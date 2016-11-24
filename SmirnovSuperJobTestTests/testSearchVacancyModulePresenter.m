//
//  testSearchVacancyModulePresenter.m
//  SuperJob
//
//  Created by Roman S on 14.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SearchVacancyModulePresenter.h"
#import "SearchVacancyModuleView.h"
#import "SearchVacancyModuleInteractor.h"

@interface testSearchVacancyModulePresenter : XCTestCase <SearchVacancyModuleViewInput, SearchVacancyModuleInteractorInput, SearchVacancyModuleRouterInput>
@property SearchVacancyModulePresenter *presenter;
@property BOOL showErrorMessageCalled;
@property BOOL dismissErrorMessageCalled;
@property BOOL presentNextModuleCalled;
@end

@implementation testSearchVacancyModulePresenter

#pragma mark - Setup

- (void)setUp
{
    [super setUp];
    self.presenter = [[SearchVacancyModulePresenter alloc] init];
    self.presenter.view = self;
    self.presenter.interactor = self;
    self.presenter.router = self;
}

- (void)tearDown
{
    self.showErrorMessageCalled = NO;
    self.dismissErrorMessageCalled = NO;
    self.presentNextModuleCalled = NO;
    [super tearDown];
}

#pragma mark - SearchVacancyModuleViewInput methods

- (void)showErrorMessage:(NSString *)errorMessage
{
    self.showErrorMessageCalled = YES;
};

- (void)dismissErrorMessage
{
    self.dismissErrorMessageCalled = YES;
};

#pragma mark - SearchVacancyModuleInteractorInput methods

- (BOOL)isGoodKeyword:(NSString *)keyword
{
    return keyword.length > 0;
}

#pragma mark - SearchVacancyModuleRouterInput methods

- (void)presentNextModuleWithKeyword:(NSString *)keyword
{
    self.presentNextModuleCalled = YES;
};

#pragma mark - Tests

- (void)testShowsNextModuleOnGoodKeyword
{
    //given
    NSString *goodKeyword = @"GoodKeyword";
    
    //when
    [self.presenter searchPressedForEnteredKeyword:goodKeyword];
    
    //then
    XCTAssertTrue(self.presentNextModuleCalled);
}

- (void)testShowsErrorOnNilKeyword
{
    //given
    
    //when
    [self.presenter searchPressedForEnteredKeyword:nil];
    
    //then
    XCTAssertTrue(self.showErrorMessageCalled);
}


- (void)testShowsErrorOnEmptyKeyword
{
    //given
    
    //when
    [self.presenter searchPressedForEnteredKeyword:@""];
    
    //then
    XCTAssertTrue(self.showErrorMessageCalled);
}

- (void)testDismissesErrorMessageWhenPressedOK
{
    //given
    
    //when
    [self.presenter errorOkPressed];
    
    //then
    XCTAssertTrue(self.dismissErrorMessageCalled);
}
@end
