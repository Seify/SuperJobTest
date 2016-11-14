//
//  testSuperJobService.m
//  SuperJob
//
//  Created by Roman S on 12.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SuperJobService.h"

@interface testSuperJobService : XCTestCase <SuperJobServiceDelegate>
@property SuperJobService *superJobService;
@property BOOL didCallbackLoad;
@property BOOL didCallbackFail;
@property NSArray *vacancies;
@property NSString *errorText;
@end

@implementation testSuperJobService

#pragma mark - Setup

- (void)setUp
{
    [super setUp];
    self.superJobService = [SuperJobService sharedService];
    self.superJobService.delegate = self;
}

- (void)tearDown
{
    self.vacancies = nil;
    self.errorText = nil;
    self.didCallbackLoad = NO;
    self.didCallbackFail = NO;
    [super tearDown];
}

#pragma mark - SuperJobServiceDelegate methods

- (void)didLoadVacancies:(NSArray *)vacancies
{
    self.vacancies = vacancies;
    self.didCallbackLoad = YES;
};

- (void)didFailLoadVacanciesWithError:(NSError *)error
{
    self.didCallbackFail = YES;
    self.errorText = error.localizedDescription;
};

#pragma mark - Helpers

- (BOOL)waitForFail:(NSTimeInterval)timeoutSecs
{
    NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:timeoutSecs];
    
    do {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:timeoutDate];
        if([timeoutDate timeIntervalSinceNow] < 0.0)
        {
            break;
        }
    } while ( !self.didCallbackFail );
    
    return self.didCallbackFail;
}

- (BOOL)waitForLoad:(NSTimeInterval)timeoutSecs
{
    NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:timeoutSecs];
    
    do {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:timeoutDate];
        if([timeoutDate timeIntervalSinceNow] < 0.0)
        {
            break;
        }
    } while ( !self.didCallbackLoad );
    
    return self.didCallbackLoad;
}

#pragma mark - Tests

- (void)testFailsOnEmptyKeyword
{
    //given
    NSString *emptyString = @"";
    
    //when
    [self.superJobService loadVacanciesForKeyword:emptyString];
    
    //then
    XCTAssertTrue([self waitForFail:1]);
    XCTAssertTrue([self.errorText isEqualToString:@"Empty keyword."]);
}

- (void)testReturnsNonemptyArray
{
    //given
    NSString *keyword = @"разработчик";
    
    //when
    [self.superJobService loadVacanciesForKeyword:keyword];
    
    //then
    XCTAssertTrue([self waitForLoad:5]);
    XCTAssertGreaterThan(self.vacancies.count, 0);
}

@end
