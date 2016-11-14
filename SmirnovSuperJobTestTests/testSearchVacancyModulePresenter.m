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

@interface testSearchVacancyModulePresenter : XCTestCase <SearchVacancyModuleViewInput, SearchVacancyModuleInteractorInput>
@property SearchVacancyModulePresenter *presenter;
@property BOOL showErrorMessageCalled;
@property BOOL dismissErrorMessageCalled;
@property NSString *errorMessage;
@property BOOL loadVacanciesForKeywordCalled;
@end

@implementation testSearchVacancyModulePresenter

#pragma mark - Setup

- (void)setUp
{
    [super setUp];
    self.presenter = [[SearchVacancyModulePresenter alloc] init];
    self.presenter.view = self;
    self.presenter.interactor = self;
}

- (void)tearDown
{
    self.showErrorMessageCalled = NO;
    self.dismissErrorMessageCalled = NO;
    self.errorMessage = nil;
    [super tearDown];
}

#pragma mark - SearchVacancyModuleViewInput methods

- (void)showErrorMessage:(NSString *)errorMessage
{
    self.errorMessage = errorMessage;
    self.showErrorMessageCalled = YES;
};

- (void)dismissErrorMessage
{
    self.dismissErrorMessageCalled = YES;
};

#pragma mark - SearchVacancyModuleInteractorInput methods

- (void)loadVacanciesForKeyword:(NSString *)keyword
{
    self.loadVacanciesForKeywordCalled = YES;
};

#pragma mark - Tests

- (void)testDismissesErrorAlertOnOKPressed
{
    //given
    
    //when
    [self.presenter errorOkPressed];
    
    //then
    XCTAssertTrue(self.dismissErrorMessageCalled);
}

- (void)testCallLoadVacanciesOnSearchPressed
{
    //given
    NSString *keyword = @"some keyword";
    
    //when
    [self.presenter searchPressedForEnteredKeyword:keyword];
    
    //then
    XCTAssertTrue(self.loadVacanciesForKeywordCalled);
}

//TODO: test show error if interactor returns error

//TODO: test show error if interactor returns empty array

//TODO: test call routing to the next module if interactor returns vacancies

@end
