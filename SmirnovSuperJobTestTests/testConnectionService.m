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
@property BOOL connectionServiceDidCallDidLoadData;
@property BOOL connectionServiceDidCallDidFailLoadData;
@property NSData *data;
@end

@implementation testConnectionService

- (void)setUp {
    [super setUp];
    self.connectionService = [ConnectionService sharedService];
    self.connectionService.delegate = self;
    self.data = nil;
    self.connectionServiceDidCallDidLoadData = NO;
    self.connectionServiceDidCallDidFailLoadData = NO;
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (BOOL)waitForDelegateCallDidLoadWithTimeout:(NSTimeInterval)timeoutSecs
{
    NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:timeoutSecs];
    
    do {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:timeoutDate];
        if([timeoutDate timeIntervalSinceNow] < 0.0)
        {
            break;
        }
    } while ( !self.connectionServiceDidCallDidLoadData );
    
    return self.connectionServiceDidCallDidLoadData;
}

- (BOOL)waitForDelegateCallDidFailWithTimeout:(NSTimeInterval)timeoutSecs
{
    NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:timeoutSecs];
    
    do {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:timeoutDate];
        if([timeoutDate timeIntervalSinceNow] < 0.0)
        {
            break;
        }
    } while ( !self.connectionServiceDidCallDidFailLoadData );
    
    return self.connectionServiceDidCallDidFailLoadData;
}


- (void)connectionServiceDidLoadData:(NSData *)data
{
    self.connectionServiceDidCallDidLoadData = YES;
    self.data = data;
};

- (void)connectionServiceDidFailLoadData
{
    self.connectionServiceDidCallDidFailLoadData = YES;
    self.data = nil;
};


- (void)testConnectionServiceCallsItsDelegateOnLoadGoodURL
{
    NSURL *goodURL = [NSURL URLWithString:@"https://api.superjob.ru/:2.0/vacancies"];
    [self.connectionService loadDataFromURL:goodURL];
    [self waitForDelegateCallDidLoadWithTimeout:10];
    XCTAssertTrue( self.connectionServiceDidCallDidLoadData );
}

- (void)testConnectionServiceCallsItsDelegateOnLoadBadURL
{
    NSURL *badURL = [NSURL URLWithString:@"nasty"];
    [self.connectionService loadDataFromURL:badURL];
    [self waitForDelegateCallDidLoadWithTimeout:10];
    XCTAssertTrue( self.connectionServiceDidCallDidFailLoadData );
}

@end
