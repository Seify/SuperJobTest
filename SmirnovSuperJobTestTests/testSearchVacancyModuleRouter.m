//
//  testSearchVacancyModuleRouter.m
//  SuperJob
//
//  Created by Roman S on 23.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SearchVacancyModuleRouter.h"

@interface testSearchVacancyModuleRouter : XCTestCase
@property SearchVacancyModuleRouter *router;
@property BOOL presentCalled;
@property UIViewController *nextModuleView;
@end

@implementation testSearchVacancyModuleRouter

#pragma mark - Setup

- (void)setUp
{
    [super setUp];
    self.router = [[SearchVacancyModuleRouter alloc] init];
    self.router.rootController = (UINavigationController *)self;
}

- (void)tearDown
{
    self.router = nil;
    self.presentCalled = NO;
    self.nextModuleView = nil;
    [super tearDown];
}

#pragma mark - UINavigationController methods

- (void)pushViewController:(UIViewController *)nextModuleView animated:(BOOL)animated
{
    self.nextModuleView = nextModuleView;
    self.presentCalled = YES;
};

- (void)popViewControllerAnimated:(BOOL)animated
{
    
}

#pragma mark - Tests

- (void)testPresentsNextModule
{
    //given
    
    //when
    [self.router presentNextModuleWithKeyword:@"подниматель пингвинов"];
    
    //then
    XCTAssertTrue(self.presentCalled);
    XCTAssert( [self.nextModuleView isKindOfClass:[UIViewController class]]);
}

@end
