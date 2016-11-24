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
@property NSString *errorMessage;
@end

@interface testShowVacanciesPageSubmodulePresenter : XCTestCase <ShowVacanciesPageSubmoduleViewInput, ShowVacanciesPageSubmoduleRouterInput, ShowVacanciesPageSubmoduleInteractorInput>
@property ShowVacanciesPageSubmodulePresenter *presenter;
@property BOOL requestPageCalled;
@property BOOL showSpinnerCalled;
@property BOOL hideSpinnerCalled;
@property BOOL showPageCalled;
@property BOOL showErrorCalled;
@property BOOL dismissErrorCalled;
@property BOOL showPrevModuleCalled;
@property VacanciesPageModel *page;
@end

@implementation testShowVacanciesPageSubmodulePresenter

#pragma mark - Setup

- (void)setUp
{
    [super setUp];
    
    self.presenter = [[ShowVacanciesPageSubmodulePresenter alloc] init];
    self.presenter.view = self;
    self.presenter.interactor = self;
    self.presenter.router = self;
    [self.presenter startWithPageID:0 Keyword:@"директор"];
}

- (void)tearDown
{
    self.presenter = nil;
    self.requestPageCalled = NO;
    self.showSpinnerCalled = NO;
    self.hideSpinnerCalled = NO;
    self.showPageCalled = NO;
    self.showErrorCalled = NO;
    self.dismissErrorCalled = NO;
    self.showPrevModuleCalled = NO;

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

- (void)showPage:(VacanciesPageModel *)page
{
    self.showPageCalled = YES;
};

- (void)showErrorMessage:(NSString *)errorMessage
{
    self.showErrorCalled = YES;
}

- (void)dismissErrorMessage
{
    self.dismissErrorCalled = YES;
};

#pragma mark - ShowVacanciesPageSubmoduleInteractorInput

- (void)requestPageForKeyword:(NSString *)keyword PageID:(int)pageID
{
    self.requestPageCalled = YES;
}

#pragma mark - ShowVacanciesPageSubmoduleRouterInput

- (void)showPrevModule
{
    self.showPrevModuleCalled = YES;
};

- (void)showNextModuleWithVacancy:(id)vacancy
{
    
};

#pragma mark - Tests

- (void)testRequestsPageOnStart
{
    //given

    //when
    
    //then
    XCTAssertTrue(self.requestPageCalled);
}

- (void)testShowErrorOnViewDidLoadIfHasOne
{
    //given
    self.presenter.errorMessage = @"Нет Интернета";
    
    //when
    [self.presenter viewDidLoad];
    
    //then
    XCTAssertTrue(self.showErrorCalled);
}

- (void)testShowsSpinnerOnViewDidLoadIfNoPage
{
    //given
    
    //when
    [self.presenter viewDidLoad];
    
    //then
    XCTAssertTrue(self.showSpinnerCalled);
}

- (void)testDoesntShowSpinnerOnViewDidLoadIfHasPage
{
    //given
    self.presenter.page = [[VacanciesPageModel alloc] init];
    
    //when
    [self.presenter viewDidLoad];
    
    //then
    XCTAssertFalse(self.showSpinnerCalled);
}

- (void)testCallsShowVacanciesWhenLoadedIfViewIsLoaded
{
    //given
    [self.presenter viewDidLoad];
    
    //when
    [self.presenter didLoadPage:[[VacanciesPageModel alloc] init]];
    
    //then
    XCTAssertTrue(self.showPageCalled);
}

- (void)testDoesntCallShowVacanciesWhenLoadedIfViewIsNotLoaded
{
    //given
    
    //when
    [self.presenter didLoadPage:[[VacanciesPageModel alloc] init]];
    
    //then
    XCTAssertFalse(self.showPageCalled);
}

- (void)testHidesSpinnerWhenPageLoadedIfViewIsLoaded
{
    //given
    [self.presenter viewDidLoad];
    
    //when
    [self.presenter didLoadPage:[[VacanciesPageModel alloc] init]];
    
    //then
    XCTAssertTrue(self.hideSpinnerCalled);
}

- (void)testDoesntHideSpinnerWhenPageLoadedIfViewIsNotLoaded
{
    //given
    
    //when
    [self.presenter didLoadPage:[[VacanciesPageModel alloc] init]];
    
    //then
    XCTAssertFalse(self.hideSpinnerCalled);
}

- (void)testSavesErrorForLaterShowWhenPageLoadingFailsIfViewNotLoaded
{
    //given
    NSString *errorMessageToShow = @"errorMessageToShow";
    
    //when
    [self.presenter didFailLoadPageWithErrorMessage:errorMessageToShow];
    
    //then
    XCTAssertFalse(self.showErrorCalled);
    XCTAssertEqualObjects(errorMessageToShow, self.presenter.errorMessage);
}

- (void)testShowsErrorWhenPageLoadingFailsIfViewLoaded
{
    //given
    [self.presenter viewDidLoad];
    
    //when
    [self.presenter didFailLoadPageWithErrorMessage:@"errorMessage"];
    
    //then
    XCTAssertTrue(self.showErrorCalled);
}

- (void)testDismissesErrorWhenOKPressed
{
    //given
    
    //when
    [self.presenter errorOkPressed];
    
    //then
    XCTAssertTrue(self.dismissErrorCalled);
}

- (void)testRoutesToPreviousModuleWhenOKPressed
{
    //given
    
    //when
    [self.presenter errorOkPressed];
    
    //then
    XCTAssertTrue(self.showPrevModuleCalled);
}

@end
