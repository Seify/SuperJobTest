//
//  testShowVacanciesModuleView.m
//  SuperJob
//
//  Created by Roman S on 19.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ShowVacanciesModuleView.h"

@interface ShowVacanciesModuleView ()<UIPageViewControllerDataSource>
@end

@interface testShowVacanciesModuleView : XCTestCase <ShowVacanciesModuleViewOutput>
@property ShowVacanciesModuleView *view;
@property BOOL didLoadCalled;
@property UIViewController *prevView;
@property UIViewController *nextView;
@end

@implementation testShowVacanciesModuleView

#pragma mark - Setup

- (void)setUp
{
    [super setUp];
    UIStoryboard *s = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.view = [s instantiateViewControllerWithIdentifier:@"ShowVacanciesModuleView"];
    self.view.output = self;
    [self.view view]; //calls viewDidLoad
    [self waitForDidLoad:2];
    
    self.prevView = [[UIViewController alloc] init];
    self.nextView = [[UIViewController alloc] init];
}

- (void)tearDown
{
    self.view = nil;
    self.didLoadCalled = NO;
    self.prevView = nil;
    self.nextView = nil;
    [super tearDown];
}

#pragma mark - ShowVacanciesModuleViewOutput methods

- (void)viewDidLoad
{
    self.didLoadCalled = YES;
}

- (UIViewController *)pageSubmoduleViewBeforePageSubmoduleView:(UIViewController *)pageSubmoduleView
{
    return self.prevView;
};

- (UIViewController *)pageSubmoduleViewAfterPageSubmoduleView:(UIViewController *)pageSubmoduleView
{
    return self.nextView;
};

#pragma mark - Helpers

- (BOOL)waitForDidLoad:(NSTimeInterval)timeoutSecs
{
    NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:timeoutSecs];
    
    do {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:timeoutDate];
        if([timeoutDate timeIntervalSinceNow] < 0.0)
        {
            break;
        }
    } while ( !self.didLoadCalled );
    
    return self.didLoadCalled;
}

#pragma mark - Tests

- (void)testNotifiesPresenterOnLoad
{
    //given
    
    //when
    
    //then
    XCTAssertTrue(self.didLoadCalled);
}

- (void)testReturnsPrevControllerFromPresenter
{
    //given
    
    //when
    UIViewController *prevView = [self.view pageViewController:[[UIPageViewController alloc] init] viewControllerBeforeViewController:[[UIViewController alloc] init]];
    
    //then
    XCTAssertEqualObjects( prevView, self.prevView );
}

- (void)testReturnsNextControllerFromPresenter
{
    //given
    
    //when
    UIViewController *nextView = [self.view pageViewController:[[UIPageViewController alloc] init] viewControllerAfterViewController:[[UIViewController alloc] init]];
    
    //then
    XCTAssertEqualObjects( nextView, self.nextView );
}


@end
