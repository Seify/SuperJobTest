//
//  testConnectionService.m
//  SuperJob
//
//  Created by Roman S on 12.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SessionService.h"

typedef void(^DataTaskCompletionHandler)(NSData *data, NSURLResponse *response, NSError *error);
typedef void(^GetAllTasksCompletionHandler)(NSArray<__kindof NSURLSessionTask *> *tasks);

@interface testSessionService : XCTestCase <SessionServiceDelegate>
//sut
@property SessionService *service;

//markers for methods calls
@property BOOL isServiseDidLoadDataCalled;
@property BOOL isServiseDidFailWithErrorCalled;
@property BOOL isCancelCalledOnTask;

//returned by ConnectionService values
@property NSUInteger taskID;
@property NSData *data;
@property NSError *error;
@property DataTaskCompletionHandler dataTaskCompletionHandler;
@property GetAllTasksCompletionHandler getAllTasksCompletionHandler;

//test values
@property NSURL *testURL;
@property int testTaskID;
@property NSData *testConnectionData;
@property NSHTTPURLResponse *testResponse200;
@property NSHTTPURLResponse *testResponse404;
@end

@interface SessionService()
@property NSURLSession *session;
@end

@implementation testSessionService

#pragma mark - Setup

- (void)setUp
{
    [super setUp];
    self.service = [[SessionService alloc] initWithSession:(NSURLSession *)self];
    self.service.delegate = self;
    self.testURL = [NSURL URLWithString:@"https://api.superjob.ru/2.0/vacancies/?keyword=ios&page=0"];
    NSString *pathToTestConnectionData = [[NSBundle bundleForClass:[self class]] pathForResource:@"testConnectionData" ofType:nil];
    self.testConnectionData = [NSData dataWithContentsOfFile:pathToTestConnectionData];
    self.testResponse200 = [[NSHTTPURLResponse alloc] initWithURL:self.testURL statusCode:200 HTTPVersion:nil headerFields:nil];
    self.testResponse404 = [[NSHTTPURLResponse alloc] initWithURL:self.testURL statusCode:404 HTTPVersion:nil headerFields:nil];
    self.testTaskID = 15;
}

- (void)tearDown
{
    self.taskID = 0;
    self.data = nil;
    self.error = nil;
    self.dataTaskCompletionHandler = nil;
    self.isServiseDidLoadDataCalled = NO;
    self.isServiseDidFailWithErrorCalled = NO;
    self.isCancelCalledOnTask = NO;
    [super tearDown];
}

#pragma mark - ConnectionServiceDelegate methods

- (void)connectionServiceDidLoadData:(NSData *)data TaskID:(NSUInteger)taskID;
{
    self.isServiseDidLoadDataCalled = YES;
    self.taskID = taskID;
    self.data = data;
};

- (void)connectionDidFailWithError:(NSError *)error TaskID:(NSUInteger)taskID;
{
    self.isServiseDidFailWithErrorCalled = YES;
    self.taskID = taskID;
    self.error = error;
};

#pragma mark - NSURLSession methods

- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler
{
    self.dataTaskCompletionHandler = completionHandler;
    return (NSURLSessionDataTask *)self;
};

- (void)getAllTasksWithCompletionHandler:(void (^)(NSArray<__kindof NSURLSessionTask *> *tasks))completionHandler
{
    self.getAllTasksCompletionHandler = completionHandler;
}

#pragma mark - NSURLSessionDataTask methods

- (void)resume
{
    
}

- (void)cancel
{
    self.isCancelCalledOnTask = YES;
}

#pragma mark - Helpers

- (BOOL)waitForLoad:(NSTimeInterval)timeoutSecs
{
    NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:timeoutSecs];
    
    do {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:timeoutDate];
        if([timeoutDate timeIntervalSinceNow] < 0.0)
        {
            break;
        }
    } while ( !self.isServiseDidLoadDataCalled );
    
    return self.isServiseDidLoadDataCalled;
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
    } while ( !self.isServiseDidFailWithErrorCalled );
    
    return self.isServiseDidFailWithErrorCalled;
}

#pragma mark - Tests

- (void)testCallsDelegateDidFailWhenErrorWithAppropriateErrorAndTaskID
{
    //given
    NSError *error = [[NSError alloc] init];
    
    //when
    [self.service loadDataFromURL:self.testURL TaskID:self.testTaskID];
    self.dataTaskCompletionHandler( self.testConnectionData, self.testResponse200, error );
    [self waitForFail:1];
    
    //then
    XCTAssertTrue(self.isServiseDidFailWithErrorCalled);
    XCTAssertEqualObjects(self.error, error);
    XCTAssertEqual(self.taskID, self.testTaskID);
}

- (void)testCallsDelegateDidFailWhenResponseCodeNot200
{
    //given
    
    //when
    [self.service loadDataFromURL:self.testURL TaskID:self.testTaskID];
    self.dataTaskCompletionHandler( self.testConnectionData, self.testResponse404, nil );
    [self waitForFail:1];
    
    //then
    XCTAssertTrue(self.isServiseDidFailWithErrorCalled);
}

- (void)testCallsDelegateDataLoadedWhenResponse200WithAppropriateDataAndTaskID
{
    //given
    
    //when
    [self.service loadDataFromURL:self.testURL TaskID:self.testTaskID];
    self.dataTaskCompletionHandler( self.testConnectionData, self.testResponse200, nil );
    [self waitForLoad:1];

    //then
    XCTAssertTrue(self.isServiseDidLoadDataCalled);
    XCTAssertEqualObjects(self.data, self.testConnectionData);
    XCTAssertEqual(self.taskID, self.testTaskID);
}

- (void)testCallsCancelOnTasksWhenShouldStopsAllTasks
{
    //given
    
    //when
    [self.service stopAllTasks];
    self.getAllTasksCompletionHandler(@[self]);
    
    //then
    XCTAssertTrue(self.isCancelCalledOnTask);
}

@end
