//
//  testShowVacanciesModuleAssembler.m
//  SuperJob
//
//  Created by Roman S on 19.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ShowVacanciesModuleRouter.h"
#import "ShowVacanciesModuleInteractor.h"
#import "ShowVacanciesModuleView.h"
#import "ShowVacanciesModuleAssembler.h"
#import "ShowVacanciesModulePresenter.h"

@interface testShowVacanciesModuleAssembler : XCTestCase

@end

@implementation testShowVacanciesModuleAssembler

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
    id data = nil;
    
    //when
    ShowVacanciesModuleView *view = (ShowVacanciesModuleView *)[ShowVacanciesModuleAssembler moduleWithRootController:rootController Data:data];
    ShowVacanciesModulePresenter *presenter = (ShowVacanciesModulePresenter *)view.output;
    ShowVacanciesModuleInteractor *interactor = (ShowVacanciesModuleInteractor *)presenter.interactor;
    ShowVacanciesModuleRouter *router = (ShowVacanciesModuleRouter *)presenter.router;
    
    //then
    XCTAssertNotNil(view);
    XCTAssertNotNil(presenter);
    XCTAssertNotNil(interactor);
    XCTAssertNotNil(router);
    
    XCTAssert( [view isMemberOfClass:[ShowVacanciesModuleView class]] );
    XCTAssert( [presenter isMemberOfClass:[ShowVacanciesModulePresenter class]] );
    XCTAssert( [interactor isMemberOfClass:[ShowVacanciesModuleInteractor class]] );
    XCTAssert( [router isMemberOfClass:[ShowVacanciesModuleRouter class]] );
    
    XCTAssert( view.output == presenter );
    XCTAssert( presenter.view == view );
    XCTAssert( presenter.interactor == interactor );
    XCTAssert( presenter.router == router );
    XCTAssert( interactor.output == presenter );
    XCTAssert( router.rootController == rootController );
}

@end
