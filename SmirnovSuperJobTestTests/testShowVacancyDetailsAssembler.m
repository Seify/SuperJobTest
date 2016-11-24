//
//  testShowVacancyDetailsAssembler.m
//  SuperJob
//
//  Created by Roman S on 24.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ShowVacancyDetailsModuleAssembler.h"
#import "ShowVacancyDetailsModuleView.h"
#import "ShowVacancyDetailsModuleInteractor.h"
#import "ShowVacancyDetailsModulePresenter.h"
#import "ShowVacancyDetailsModuleRouter.h"

@interface testShowVacancyDetailsAssembler : XCTestCase

@end

@implementation testShowVacancyDetailsAssembler

#pragma mark - Setup

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

#pragma mark - Tests
- (void)testAllComponentsAndConnectionsAreSet
{
    //given
    VacancyModel *testVacancy = [[VacancyModel alloc] init];
    UINavigationController *testRootController = [[UINavigationController alloc] init];
    
    //when
    ShowVacancyDetailsModuleView *view = (ShowVacancyDetailsModuleView *)[ShowVacancyDetailsModuleAssembler moduleWithRootController:testRootController Vacancy:testVacancy];
    ShowVacancyDetailsModulePresenter *presenter = (ShowVacancyDetailsModulePresenter *)view.output;
    ShowVacancyDetailsModuleInteractor *interactor = (ShowVacancyDetailsModuleInteractor *)presenter.interactor;
    ShowVacancyDetailsModuleRouter *router = (ShowVacancyDetailsModuleRouter *)presenter.router;
    
    //then
    XCTAssert( [view isMemberOfClass:[ShowVacancyDetailsModuleView class]] );
    XCTAssert( [presenter isMemberOfClass:[ShowVacancyDetailsModulePresenter class]] );
    XCTAssert( [interactor isMemberOfClass:[ShowVacancyDetailsModuleInteractor class]] );
    XCTAssert( [router isMemberOfClass:[ShowVacancyDetailsModuleRouter class]] );
    
    XCTAssertEqualObjects(view.output, presenter);
    XCTAssertEqualObjects(presenter.view, view);
    XCTAssertEqualObjects(presenter.interactor, interactor);
    XCTAssertEqualObjects(presenter.router, router);
    XCTAssertEqualObjects(presenter.vacancy, testVacancy);
    XCTAssertEqualObjects(interactor.output, presenter);
    XCTAssertEqualObjects(router.rootController, testRootController);
}
@end
