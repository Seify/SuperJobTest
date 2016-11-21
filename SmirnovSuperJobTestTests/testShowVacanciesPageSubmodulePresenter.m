//
//  testShowVacanciesPageSubmodulePresenter.m
//  SuperJob
//
//  Created by Roman S on 21.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ShowVacanciesPageSubmoduleView.h"
#import "ShowVacanciesPageSubmoduleInteractor.h"
#import "ShowVacanciesPageSubmodulePresenter.h"
#import "ShowVacanciesPageSubmoduleRouter.h"
#import "VacancyModel.h"


@interface ShowVacanciesPageSubmodulePresenter()
@property NSArray *vacancies;
@end

@interface testShowVacanciesPageSubmodulePresenter : XCTestCase <ShowVacanciesPageSubmoduleViewInput, ShowVacanciesPageSubmoduleRouterInput, ShowVacanciesPageSubmoduleInteractorInput>
@property ShowVacanciesPageSubmodulePresenter *presenter;

@property BOOL showVacanciesCalled;
@property BOOL showSpinnerCalled;
@property BOOL hideSpinnerCalled;
@property BOOL requestDataCalled;
@property BOOL showErrorCalled;
@property BOOL showNextPageSubmoduleCalled;
@property BOOL showPrevPageSubmoduleCalled;
@property BOOL showNextModuleCalled;
@end

//@interface testSearchVacancyModulePresenter : XCTestCase <SearchVacancyModuleViewInput, SearchVacancyModuleInteractorInput, SearchVacancyModuleRouterInput>
//@property SearchVacancyModulePresenter *presenter;
//@property BOOL showErrorMessageCalled;
//@property BOOL dismissErrorMessageCalled;
//@property NSString *errorMessage;
//@property BOOL loadVacanciesForKeywordCalled;
//@property id nextModuleData;
//@property BOOL routeToTheNextModuleCalled;
//@end

@implementation testShowVacanciesPageSubmodulePresenter

#pragma mark - Setup

- (void)setUp
{
    [super setUp];
    self.presenter = [[ShowVacanciesPageSubmodulePresenter alloc] init];
    self.presenter.view = self;
    self.presenter.interactor = self;
    self.presenter.router = self;
}

- (void)tearDown
{
    self.showSpinnerCalled = NO;
    self.hideSpinnerCalled = NO;
    self.showVacanciesCalled = NO;
    self.requestDataCalled = NO;
    self.showErrorCalled = NO;
    [super tearDown];
}

#pragma mark - ShowVacanciesPageSubmoduleViewInput methods

- (void)showSpinner
{
    self.showSpinnerCalled = YES;
};

- (void)hideSpinner
{
    self.hideSpinnerCalled = YES;
};

- (void)showData:(id)data
{
    self.showVacanciesCalled = YES;
};

- (void)showErrorMessage:(NSString *)errorMessage
{
    self.showErrorCalled = YES;
}

#pragma mark - ShowVacanciesPageSubmoduleInteractorInput

- (void)requestVacanciesForKeyword:(NSString *)keyword Page:(int)page
{
    self.requestDataCalled = YES;
}

#pragma mark - ShowVacanciesPageSubmoduleRouterInput

- (void)showPrevPageSubmodule
{
    self.showPrevPageSubmoduleCalled = YES;
};

- (void)showNextPageSubmodule
{
    self.showNextPageSubmoduleCalled = YES;
};

- (void)showNextModule
{
    self.showNextModuleCalled = YES;
};

#pragma mark - Tests

- (void)testRequestsVacanciesOnStartIfNoVacancies
{
    //given
    self.presenter.vacancies = nil;
    
    //when
    [self.presenter start];
    
    //then
    XCTAssertTrue(self.requestDataCalled);
}

- (void)testCallsShowVacanciesWhenLoadedIfViewIsLoaded
{
    //given
    VacancyModel *vm = [[VacancyModel alloc] init];
    [self.presenter viewDidLoad];
    
    //when
    [self.presenter didLoadVacancies:@[vm]];
    
    //then
    XCTAssertTrue(self.showVacanciesCalled);
}

- (void)testCallsShowErrorWhenVacancyLoadingFails
{
    //given
    NSString *errorMessage = @"errorMessage";
    
    //when
    [self.presenter didFailLoadVacanciesWithErrorMessage:errorMessage];
    
    //then
    XCTAssertTrue(self.showErrorCalled);
}

- (void)testShowsVacanciesOnLoadIfHasAny
{
    //given
    VacancyModel *vm = [[VacancyModel alloc] init];
    self.presenter.vacancies = @[vm];
    
    //when
    [self.presenter viewDidLoad];
    
    //then
    XCTAssertTrue(self.showVacanciesCalled);
}

- (void)testShowsSpinnerOnLoadIfNoData
{
    //given
    self.presenter.vacancies = nil;
    
    //when
    [self.presenter viewDidLoad];
    
    //then
    XCTAssertTrue(self.showSpinnerCalled);
}

- (void)testCallsShowPrevPageOnSwipeLeft
{
    //given
    
    //when
    [self.presenter userDidSwipeLeft];
    
    //then
    XCTAssertTrue(self.showPrevPageSubmoduleCalled);
}

- (void)testCallsShowNextPageOnSwipeRight
{
    //given
    
    //when
    [self.presenter userDidSwipeRight];
    
    //then
    XCTAssertTrue(self.showNextPageSubmoduleCalled);
}

@end
