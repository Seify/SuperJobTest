//
//  testSearchVacancyModulePresenter.m
//  SuperJob
//
//  Created by Roman S on 14.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "VacancyModel.h"
#import "SearchVacancyModulePresenter.h"
#import "SearchVacancyModuleView.h"
#import "SearchVacancyModuleInteractor.h"

@interface testSearchVacancyModulePresenter : XCTestCase <SearchVacancyModuleViewInput, SearchVacancyModuleInteractorInput, SearchVacancyModuleRouterInput>
@property SearchVacancyModulePresenter *presenter;
@property BOOL showErrorMessageCalled;
@property BOOL dismissErrorMessageCalled;
@property NSString *errorMessage;
@property BOOL loadVacanciesForKeywordCalled;
@property id nextModuleData;
@property BOOL routeToTheNextModuleCalled;
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
    self.errorMessage = nil;
    self.routeToTheNextModuleCalled = NO;
    self.nextModuleData = nil;
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

#pragma mark - SearchVacancyModuleRouterInput methods

- (void)presentNextModuleWithData:(id)data
{
    self.nextModuleData = data;
    self.routeToTheNextModuleCalled = YES;
};

#pragma mark - Helpers

- (NSArray *)testVacancies
{
    VacancyModel *vm = [[VacancyModel alloc] init];
    vm.profession = @"грузчик";
    vm.educationName = @"средне-специальное";
    return @[vm];
}

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

- (void)testShowErrorWhenLoadingFails
{
    //given
    NSString *errorMessage = @"some error";
    
    //when
    [self.presenter didFailLoadVacanciesWithErrorMessage:errorMessage];
    
    //then
    XCTAssertTrue( self.showErrorMessageCalled );
    XCTAssert([self.errorMessage isEqualToString:errorMessage]);
}

- (void)testShowErrorWhenLoadedEmptyArray
{
    //given
    NSArray *vacancies = @[];
    
    //when
    [self.presenter didLoadVacancies:vacancies];
    
    //then
    XCTAssertTrue(self.showErrorMessageCalled);
    XCTAssert( [self.errorMessage isEqualToString:@"Nothing was found. Try another keywords."] );
}

- (void)testCallRoutingToNextModuleWhenLoadedVacancies
{
    //given
    NSArray *testVacansies = [self testVacancies];
    
    //when
    [self.presenter didLoadVacancies:testVacansies];
    
    //then
    XCTAssertTrue(self.routeToTheNextModuleCalled);
    XCTAssert([testVacansies isEqual:self.nextModuleData]);
}

@end
