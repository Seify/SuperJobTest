//
//  SuperJobService.m
//  SuperJob
//
//  Created by Roman S on 12.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import "SuperJobService.h"
#import "VacancyBuilder.h"

@interface SuperJobService()
@property id<SessionServiceProtocol> sessionService;
@property Class JSONSerializationClass;
@property Class VacasyBuilderClass;
@property NSMutableDictionary *tasksData;
@property int taskCounter;
@end

const NSString *SuperJobAPIKey = @"v1.r0764bb4369e723b9d84160bb38d2718b2efb53d7f6400dbcb46f81e8737eb5c4b826437e.3b1f5943602b514b61c078194bed419ed1057f8f";

@implementation SuperJobService

+ (instancetype)sharedService
{
    static SuperJobService *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[SuperJobService alloc] init];
    });
    
    return _sharedInstance;
};

- (instancetype)init
{
    if ( self = [super init] )
    {
        self.sessionService = [[SessionService alloc] initWithSession:[self createSession] ReachabilityManager:[ReachabilityManager sharedManager]];
        self.sessionService.delegate = self;
        self.taskCounter = 0;
        self.tasksData = [NSMutableDictionary dictionary];
        self.JSONSerializationClass = [NSJSONSerialization class];
        self.VacasyBuilderClass = [VacancyBuilder class];
    }
    return self;
}

- (NSURLSession *)createSession
{
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.HTTPAdditionalHeaders = @{ @"X-Api-App-Id" : SuperJobAPIKey };
    return [NSURLSession sessionWithConfiguration:sessionConfiguration];
}

- (NSURL *)urlForKeyword:(NSString *)keyword PageID:(int)pageID
{
    NSString *escapedKeyword = [keyword stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *urlAsString = [NSString stringWithFormat:@"https://api.superjob.ru/2.0/vacancies/?keyword=%@&page=%d", escapedKeyword, pageID];
    return [[NSURL alloc] initWithString:urlAsString];
}

- (void)loadPageForKeyword:(NSString *)keyword PageID:(int)pageID Delegate:(id<SuperJobServiceDelegate>)delegate
{
    NSURL *url = [self urlForKeyword:keyword PageID:pageID];
    int taskID = self.taskCounter++;
    NSDictionary *taskData = @{ @"delegate"   : delegate,
                                @"pageID"   : @(pageID),
                                @"keyword"  : keyword};
    self.tasksData[@(taskID)] = taskData;

    [self.sessionService loadDataFromURL:url TaskID:taskID];
};

- (void)connectionServiceDidLoadData:(NSData *)data TaskID:(NSUInteger)taskID
{
    NSDictionary *taskData = self.tasksData[@(taskID)];
    id delegate = taskData[@"delegate"];
    NSAssert(delegate, @"No delegate!");
    NSError *serializationError = nil;
    id JSONdata = [self.JSONSerializationClass JSONObjectWithData:data options:0 error:&serializationError];
    if ( serializationError )
    {
        [delegate didFailLoadPageWithError:serializationError];
    }
    else
    {
        int pageID = [taskData[@"pageID"] intValue];
        NSString *keyword = taskData[@"keyword"];
        NSError *builderError = nil;
        VacanciesPageModel *pageModel = [self.VacasyBuilderClass pageFromJSON:JSONdata PageID:pageID Keyword:keyword Error:&builderError];
        if ( builderError )
        {
            [delegate didFailLoadPageWithError:builderError];
        }
        else
        {
            [delegate didLoadPage:pageModel];
        }
    }
    
    self.tasksData[@(taskID)] = nil;
}

- (void)connectionDidFailWithError:(NSError *)error TaskID:(NSUInteger)taskID
{
    NSDictionary *taskData = self.tasksData[@(taskID)];
    [taskData[@"delegate"] didFailLoadPageWithError:error];
    self.tasksData[@(taskID)] = nil;
}

- (void)cancelAllTasks
{
    self.tasksData = [NSMutableDictionary dictionary];
    [self.sessionService stopAllTasks];
};

@end
