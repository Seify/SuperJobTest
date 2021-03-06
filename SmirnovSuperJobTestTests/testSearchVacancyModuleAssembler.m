//
//  testSearchVacancyModuleAssembler.m
//  SuperJob
//
//  Created by Roman S on 16.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SearchVacancyModuleAssembler.h"
#import "SearchVacancyModuleView.h"
#import "SearchVacancyModuleInteractor.h"
#import "SearchVacancyModulePresenter.h"
#import "SearchVacancyModuleRouter.h"

@interface testSearchVacancyModuleAssembler : XCTestCase

@end

@implementation testSearchVacancyModuleAssembler

#pragma mark - Setup

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Tests

- (void)testAllComponentsAndConnectionsAreSet
{
    //given
    UINavigationController *rootController = [[UINavigationController alloc] init];
    
    //when
    SearchVacancyModuleView *view = (SearchVacancyModuleView *)[SearchVacancyModuleAssembler createModuleWithRootController:rootController];
    SearchVacancyModulePresenter *presenter = (SearchVacancyModulePresenter *)view.output;
    SearchVacancyModuleInteractor *interactor = (SearchVacancyModuleInteractor *)presenter.interactor;
    SearchVacancyModuleRouter *router = (SearchVacancyModuleRouter *)presenter.router;
    
    //then
    XCTAssert( [view isMemberOfClass:[SearchVacancyModuleView class]] );
    XCTAssert( [presenter isMemberOfClass:[SearchVacancyModulePresenter class]] );
    XCTAssert( [interactor isMemberOfClass:[SearchVacancyModuleInteractor class]] );
    XCTAssert( [router isMemberOfClass:[SearchVacancyModuleRouter class]] );
    
    XCTAssert( view.output == presenter );
    XCTAssert( presenter.view == view );
    XCTAssert( presenter.interactor == interactor );
    XCTAssert( presenter.router == router );
    XCTAssert( interactor.output == presenter );
    XCTAssert( router.rootController == rootController );
}

@end
