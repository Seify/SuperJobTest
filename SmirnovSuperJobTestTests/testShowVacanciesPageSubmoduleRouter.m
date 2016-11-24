//
//  testShowVacanciesPageSubmoduleRouter.m
//  SuperJob
//
//  Created by Roman S on 23.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ShowVacanciesPageSubmoduleRouter.h"

@interface testShowVacanciesPageSubmoduleRouter : XCTestCase<ShowVacanciesModuleRouterInput>
@property ShowVacanciesPageSubmoduleRouter *router;
@property BOOL routeToPrevModuleCalled;
@property BOOL routeToNextModuleCalled;
@property id vacancy;
@end

@implementation testShowVacanciesPageSubmoduleRouter

#pragma mark - Setup

- (void)setUp
{
    [super setUp];
    self.router = [[ShowVacanciesPageSubmoduleRouter alloc] init];
    self.router.parentRouter = self;
}

- (void)tearDown
{
    self.routeToPrevModuleCalled = NO;
    self.routeToNextModuleCalled = NO;
    self.vacancy = nil;
    [super tearDown];
}

#pragma mark - Parent router methods

- (UIViewController *)pageSubmoduleWithPage:(int)page Keyword:(NSString *)keyword
{
    return nil;
};

- (UIViewController *)pageSubmoduleViewBeforePageSubmoduleView:(UIViewController *)pageSubmoduleView
{
    return nil;
}

- (UIViewController *)pageSubmoduleViewAfterPageSubmoduleView:(UIViewController *)pageSubmoduleView
{
    return nil;
};

- (void)routeToPrevModule
{
    self.routeToPrevModuleCalled = YES;
};

- (void)routeToNextModuleWithVacancy:(id)vacancy
{
    self.routeToNextModuleCalled = YES;
    self.vacancy = vacancy;
};

#pragma mark - Tests

- (void)testRouteToPrevModulePassedToParentRouter
{
    //given
    
    //when
    [self.router showPrevModule];
    
    //then
    XCTAssertTrue(self.routeToPrevModuleCalled);
}

- (void)testRouteToNextModulePassedToParentRouterWithVacancy
{
    //given
    id vacancy = [[NSObject alloc] init];
    
    //when
    [self.router showNextModuleWithVacancy:vacancy];
    
    //then
    XCTAssertTrue(self.routeToNextModuleCalled);
    XCTAssertEqualObjects(vacancy, self.vacancy);
}

@end
