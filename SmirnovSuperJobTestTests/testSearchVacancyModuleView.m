//
//  testSearchVacancyModuleView.m
//  SuperJob
//
//  Created by Roman S on 14.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SearchVacancyModuleView.h"

@interface SearchVacancyModuleView()
@property (weak) UIAlertController *alert;
@end

@interface testSearchVacancyModuleView : XCTestCase <SearchVacancyModuleViewOutput>
@property SearchVacancyModuleView *view;
@property BOOL didLoadCalled;
@end

@implementation testSearchVacancyModuleView

#pragma mark - Setup

- (void)setUp
{
    [super setUp];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    self.view = [storyboard instantiateViewControllerWithIdentifier:@"SearchVacancyModuleView"];
    self.view.output = self;
    [self.view view]; //to call ViewDidLoad
    [self waitForDidLoad:2];
}

- (void)tearDown
{
    self.view = nil;
    self.didLoadCalled = NO;
    [super tearDown];
}

#pragma mark - SearchVacancyModuleViewOutput methods

- (void)didLoad
{
    self.didLoadCalled = YES;
};

- (void)searchPressedForEnteredKeyword:(NSString *)keyword
{
    
};

- (void)errorOkPressed
{
    
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

- (void)testErrorMessageStringIsCorrect
{
    //given
    NSString *errorMessage = @"Empty keyword";
    
    //when
    [self.view showErrorMessage:errorMessage];
    
    //then
    XCTAssert([errorMessage isEqualToString:self.view.alert.message]);
}

- (void)testErrorMessageDismissal
{
    //given
    NSString *errorMessage = @"Empty keyword";
    [self.view showErrorMessage:errorMessage];
    
    //when
    [self.view dismissErrorMessage];
    
    //then
    XCTAssertNil(self.view.alert);
}
@end
