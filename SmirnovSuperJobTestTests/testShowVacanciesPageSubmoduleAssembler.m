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

#pragma mark - Setup

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Tests
- (void)testAllComponentsAndConnectionsAreSet
{
    //given
    id<ShowVacanciesModuleRouterInput> parentRouter = (id<ShowVacanciesModuleRouterInput>)[[NSObject alloc] init];
    
    //when
    ShowVacanciesPageSubmoduleView *view = (ShowVacanciesPageSubmoduleView *)[ShowVacanciesPageSubmoduleAssembler submoduleWithParentRouter:parentRouter Page:0 Keyword:@"грузчик"];
    ShowVacanciesPageSubmodulePresenter *presenter = (ShowVacanciesPageSubmodulePresenter *)view.output;
    ShowVacanciesPageSubmoduleInteractor *interactor = (ShowVacanciesPageSubmoduleInteractor *)presenter.interactor;
    ShowVacanciesPageSubmoduleRouter *router = (ShowVacanciesPageSubmoduleRouter *)presenter.router;
    
    //then
    XCTAssert( [view isMemberOfClass:[ShowVacanciesPageSubmoduleView class]] );
    XCTAssert( [presenter isMemberOfClass:[ShowVacanciesPageSubmodulePresenter class]] );
    XCTAssert( [interactor isMemberOfClass:[ShowVacanciesPageSubmoduleInteractor class]] );
    XCTAssert( [router isMemberOfClass:[ShowVacanciesPageSubmoduleRouter class]] );
    
    XCTAssert( view.output == presenter );
    XCTAssert( presenter.view == view );
    XCTAssert( presenter.interactor == interactor );
    XCTAssert( presenter.router == router );
    XCTAssert( interactor.output == presenter );
    XCTAssert( router.output == presenter );
    XCTAssert( router.parentRouter == parentRouter );
}
@end
