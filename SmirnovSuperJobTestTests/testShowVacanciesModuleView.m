//
//  testShowVacanciesModuleView.m
//  SuperJob
//
//  Created by Roman S on 19.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ShowVacanciesModuleView.h"

@interface testShowVacanciesModuleView : XCTestCase <ShowVacanciesModuleViewOutput>
@property ShowVacanciesModuleView *showVacanciesModuleView;
@property BOOL didLoadCalled;
@end

@implementation testShowVacanciesModuleView

#pragma mark - Setup

- (void)setUp
{
    [super setUp];
    self.showVacanciesModuleView = [[ShowVacanciesModuleView alloc] init];
    self.showVacanciesModuleView.output = self;
}

- (void)tearDown
{
    self.showVacanciesModuleView = nil;
    self.didLoadCalled = NO;
    [super tearDown];
}

#pragma mark - ShowVacanciesModuleViewOutput methods

- (void)viewDidLoad
{
    self.didLoadCalled = YES;
}

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
    [self.showVacanciesModuleView viewDidLoad];
    
    //then
    [self waitForDidLoad:2];
    XCTAssertTrue(self.didLoadCalled);
}

@end
