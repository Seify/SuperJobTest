//
//  testShowVacanciesPageSubmoduleAsembler.m
//  SuperJob
//
//  Created by Roman S on 19.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ShowVacanciesPageSubmoduleAssembler.h"
#import "ShowVacanciesPageSubmoduleView.h"
#import "ShowVacanciesPageSubmoduleInteractor.h"
#import "ShowVacanciesPageSubmodulePresenter.h"
#import "ShowVacanciesPageSubmoduleRouter.h"

@interface testShowVacanciesPageSubmoduleAssembler : XCTestCase

@end

#pragma mark - Setup

@implementation testShowVacanciesPageSubmoduleAssembler

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
    id<ShowVacanciesPageSubmoduleRouterOutput> routerOutput = (id<ShowVacanciesPageSubmoduleRouterOutput>)[[NSObject alloc] init];
    id data = nil;
    int page = 3;
    NSString *keyword = @"грузчик";
    
    //when
    ShowVacanciesPageSubmoduleView *view = (ShowVacanciesPageSubmoduleView *)[ShowVacanciesPageSubmoduleAssembler submoduleWithRooterOutput:routerOutput Data:data Page:page Keyword:keyword];
    ShowVacanciesPageSubmodulePresenter *presenter = (ShowVacanciesPageSubmodulePresenter *)view.output;
    ShowVacanciesPageSubmoduleInteractor *interactor = (ShowVacanciesPageSubmoduleInteractor *)presenter.interactor;
    ShowVacanciesPageSubmoduleRouter *router = (ShowVacanciesPageSubmoduleRouter *)presenter.router;
    
    //then
    XCTAssertNotNil(view);
    XCTAssertNotNil(presenter);
    XCTAssertNotNil(interactor);
    XCTAssertNotNil(router);
    
    XCTAssert( [view isMemberOfClass:[ShowVacanciesPageSubmoduleView class]] );
    XCTAssert( [presenter isMemberOfClass:[ShowVacanciesPageSubmodulePresenter class]] );
    XCTAssert( [interactor isMemberOfClass:[ShowVacanciesPageSubmoduleInteractor class]] );
    XCTAssert( [router isMemberOfClass:[ShowVacanciesPageSubmoduleRouter class]] );
    
    XCTAssert( view.output == presenter );
    XCTAssert( presenter.view == view );
    XCTAssert( presenter.interactor == interactor );
    XCTAssert( presenter.router == router );
    XCTAssert( interactor.output == presenter );
    XCTAssert( router.output == routerOutput );
}

@end
