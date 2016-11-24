//
//  testShowVacanciesModulePresenter.m
//  SuperJob
//
//  Created by Roman S on 21.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ShowVacanciesModuleView.h"
#import "ShowVacanciesModuleInteractor.h"
#import "ShowVacanciesModulePresenter.h"
#import "ShowVacanciesModuleRouter.h"

@interface testShowVacanciesModulePresenter : XCTestCase<ShowVacanciesModuleViewInput, ShowVacanciesModuleInteractorInput, ShowVacanciesModuleRouterInput>
@property ShowVacanciesModulePresenter *presenter;
@property NSString *startKeyword;
@property NSString *passedToRouterKeyword;
@property UIViewController *prevPageView;
@property UIViewController *nextPageView;
@property BOOL stopAllTasksCalled;
@end

@implementation testShowVacanciesModulePresenter

#pragma mark - Setup

- (void)setUp
{
    [super setUp];
    
    self.startKeyword = @"Терминатор";
    self.prevPageView = [[UIViewController alloc] init];
    self.nextPageView = [[UIViewController alloc] init];
    
    self.presenter = [[ShowVacanciesModulePresenter alloc] init];
    self.presenter.interactor = self;
    self.presenter.view = self;
    self.presenter.router = self;
    [self.presenter startWithKeyword:self.startKeyword];
}

- (void)tearDown
{
    self.presenter = nil;
    self.startKeyword = nil;
    self.prevPageView = nil;
    self.nextPageView = nil;
    self.stopAllTasksCalled = NO;
    [super tearDown];
}

#pragma mark - ShowVacanciesModuleRouterInput methods

- (UIViewController *)pageSubmoduleWithPage:(int)page Keyword:(NSString *)keyword
{
    self.passedToRouterKeyword = keyword;
    return nil;
};

- (UIViewController *)pageSubmoduleViewBeforePageSubmoduleView:(UIViewController *)pageSubmoduleView
{
    return self.prevPageView;
};

- (UIViewController *)pageSubmoduleViewAfterPageSubmoduleView:(UIViewController *)pageSubmoduleView
{
    return self.nextPageView;
}

- (void)routeToPrevModule
{
    
};

- (void)routeToNextModuleWithVacancy:(id)vacancy
{
    
};

#pragma mark - ShowVacanciesModuleViewInput methods

- (void)showPageSubmodule:(UIViewController *)pageSubmodule
{
    
}

#pragma mark - ShowVacanciesModuleInteractorInput methods

- (void)stopAllTasks
{
    self.stopAllTasksCalled = YES;
};

#pragma mark - Tests

- (void)testRequestsFirstPageWithRightKeywordOnViewDidLoad
{
    //given
    
    //when
    [self.presenter viewDidLoad];
    
    //then
    XCTAssertEqualObjects(self.startKeyword, self.passedToRouterKeyword);
}

- (void)testReturnsPrevPageFromRouter
{
    //given
    
    //when
    UIViewController *prevPageView =  [self.presenter pageSubmoduleViewBeforePageSubmoduleView:[[UIViewController alloc] init]];
    
    //then
    XCTAssertEqualObjects(self.prevPageView, prevPageView);
}

- (void)testReturnsNextPageFromRouter
{
    //given
    
    //when
    UIViewController *nextPageView =  [self.presenter pageSubmoduleViewAfterPageSubmoduleView:[[UIViewController alloc] init]];
    
    //then
    XCTAssertEqualObjects(self.nextPageView, nextPageView);
}

- (void)testStopsAllTasksWhenPrevModulePresented
{
    //given
    
    //when
    [self.presenter willRouteToPrevModule];
    
    //then
    XCTAssertTrue(self.stopAllTasksCalled);
}

@end
