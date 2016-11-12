//
//  testConnectionService.m
//  SuperJob
//
//  Created by Roman S on 12.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ConnectionService.h"

@interface testConnectionService : XCTestCase <ConnectionServiceDelegate>
@property ConnectionService *connectionService;
@property BOOL didCallbackLoad;
@property BOOL didCallbackFail;
@property NSData *data;
@end

@implementation testConnectionService

- (void)setUp {
    [super setUp];
    self.connectionService = [ConnectionService sharedService];
    self.connectionService.delegate = self;
}

- (void)tearDown
{
    self.data = nil;
    self.didCallbackLoad = NO;
    self.didCallbackFail = NO;
    [super tearDown];
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


- (void)connectionServiceDidLoadData:(NSData *)data
{
    self.didCallbackLoad = YES;
    self.data = data;
};

- (void)connectionDidFailWithError:(NSError *)error
{
    self.didCallbackFail = YES;
    self.data = nil;
};


- (void)testConnectionServiceCallsItsDelegateOnLoadGoodURL
{
    NSURL *goodURL = [NSURL URLWithString:@"https://api.superjob.ru/:2.0/vacancies"];
    [self.connectionService loadDataFromURL:goodURL];
    [self waitForLoad:100];
    XCTAssertTrue( self.didCallbackLoad );
}

- (void)testConnectionServiceCallsItsDelegateOnLoadBadURL
{
    NSURL *badURL = [NSURL URLWithString:@"nasty"];
    [self.connectionService loadDataFromURL:badURL];
    [self waitForFail:100];
    XCTAssertTrue( self.didCallbackFail );
}

@end
