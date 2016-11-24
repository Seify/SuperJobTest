//
//  testSuperJobService.m
//  SuperJob
//
//  Created by Roman S on 12.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SuperJobService.h"

@interface SuperJobService()
@property id<SessionServiceProtocol> sessionService;
@property Class JSONSerializationClass;
@property Class VacasyBuilderClass;
@property (atomic) NSMutableDictionary *tasksData;
@property int taskCounter;
@end

@interface testSuperJobService : XCTestCase <SuperJobServiceDelegate, SessionServiceProtocol>

//sut
@property SuperJobService *superJobService;

//just to comform protocol
@property (weak) id<SessionServiceDelegate> delegate;

//markers for methods being called
@property BOOL isServiceCalledLoadDataOnDelegate;
@property BOOL isServiceCalledFailedOnDelegate;
@property BOOL isCancelAllTasksCalledOnService;

@property VacanciesPageModel *pageReturnedToDelegate;
@property NSError *error;
@end

static NSError *serializationError;
static NSError *builderError;
static VacanciesPageModel *pageToReturnToSuperjobService;

@implementation testSuperJobService

#pragma mark - Setup

- (void)setUp
{
    [super setUp];
    self.superJobService = [[SuperJobService alloc] init];
    self.superJobService.sessionService = self;
    self.superJobService.JSONSerializationClass = [self class];
    self.superJobService.VacasyBuilderClass = [self class];
}

- (void)tearDown
{
    serializationError = nil;
    builderError = nil;
    pageToReturnToSuperjobService = nil;
    
    self.pageReturnedToDelegate = nil;
    self.error = nil;
    self.isServiceCalledLoadDataOnDelegate = NO;
    self.isServiceCalledFailedOnDelegate = NO;
    self.isCancelAllTasksCalledOnService = NO;
    [super tearDown];
}

#pragma mark - SuperJobServiceDelegate methods

- (void)didLoadPage:(VacanciesPageModel *)page
{
    self.pageReturnedToDelegate = page;
    self.isServiceCalledLoadDataOnDelegate = YES;
};

- (void)didFailLoadPageWithError:(NSError *)error
{
    self.isServiceCalledFailedOnDelegate = YES;
    self.error = error;
};

#pragma mark - NSJSONSerialization methods

+ (nullable id)JSONObjectWithData:(NSData *)data options:(NSJSONReadingOptions)opt error:(NSError **)error
{
    *error = serializationError;
    return nil;
};

#pragma mark - VacancyBuilderProtocol methods

+ (VacanciesPageModel *)pageFromJSON:(NSDictionary *)JSONDict PageID:(int)pageID Keyword:(NSString *)keyword Error:(NSError **)error
{
    *error = builderError;
    return pageToReturnToSuperjobService;
}

#pragma mark - SessionServiceProtocol methods

- (void)loadDataFromURL:(NSURL *)url TaskID:(int)taskID
{
    
};

- (void)stopAllTasks
{
    self.isCancelAllTasksCalledOnService = YES;
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
    } while ( !self.isServiceCalledFailedOnDelegate );
    
    return self.isServiceCalledFailedOnDelegate;
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
    } while ( !self.isServiceCalledLoadDataOnDelegate );
    
    return self.isServiceCalledLoadDataOnDelegate;
}

#pragma mark - Tests

- (void)testCallsFailOnSerializationError
{
    //given
    serializationError = [[NSError alloc] initWithDomain:@"serializationError" code:123 userInfo:nil];
    
    //when
    [self.superJobService loadPageForKeyword:@"test" PageID:0 Delegate:self];
    [self.superJobService connectionServiceDidLoadData:[NSData data] TaskID:0];
    [self waitForFail:1];
    
    //then
    XCTAssertTrue(self.isServiceCalledFailedOnDelegate);
    XCTAssertEqualObjects(self.error, serializationError);
}

- (void)testCallsFailOnBuilderError
{
    //given
    builderError = [[NSError alloc] initWithDomain:@"builderError" code:123 userInfo:nil];
    
    //when
    [self.superJobService loadPageForKeyword:@"test" PageID:0 Delegate:self];
    [self.superJobService connectionServiceDidLoadData:[NSData data] TaskID:0];
    [self waitForFail:1];
    
    //then
    XCTAssertTrue(self.isServiceCalledFailedOnDelegate);
    XCTAssertEqualObjects(self.error, builderError);
}

- (void)testCallsDidLoadIfNoSerializationOrBuilderError
{
    //given
    builderError = nil;
    serializationError = nil;
    pageToReturnToSuperjobService = [[VacanciesPageModel alloc] init];
    
    //when
    [self.superJobService loadPageForKeyword:@"test" PageID:0 Delegate:self];
    [self.superJobService connectionServiceDidLoadData:[NSData data] TaskID:0];
    [self waitForLoad:1];
    
    //then
    XCTAssertTrue(self.isServiceCalledLoadDataOnDelegate);
    XCTAssertEqualObjects(self.pageReturnedToDelegate, pageToReturnToSuperjobService);
}

- (void)testCallsFailIfServiceFails
{
    NSError *serviceError = [NSError errorWithDomain:@"serviceError" code:567 userInfo:nil];
    
    //when
    [self.superJobService loadPageForKeyword:@"test" PageID:0 Delegate:self];
    [self.superJobService connectionDidFailWithError:serviceError TaskID:0];
    [self waitForFail:1];
    
    //then
    XCTAssertTrue(self.isServiceCalledFailedOnDelegate);
    XCTAssertEqualObjects(self.error, serviceError);
}

- (void)testCallsServisesCancelAllTasks
{
    //given
    
    //when
    [self.superJobService cancelAllTasks];
    
    //then
    XCTAssertTrue(self.isCancelAllTasksCalledOnService);
}
@end
