//
//  ConnectionService.m
//  SuperJob
//
//  Created by Roman S on 12.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import "SessionService.h"

@interface SessionService()
@property NSURLSession *session;
@property id<ReachabilityManagerProtocol> reachabilityManager;
- (NSError *)errorForResponse:(NSURLResponse *)response;
@end


@implementation SessionService

- (instancetype)initWithSession:(NSURLSession *)session ReachabilityManager:(id<ReachabilityManagerProtocol>)reachabilityManager
{
    if ( self = [super init] )
    {
        self.session = session;
        self.reachabilityManager = reachabilityManager;
    }
    
    return self;
}

- (NSError *)errorForResponse:(NSURLResponse *)response
{
    if ( [response isKindOfClass:[NSHTTPURLResponse class]] )
    {
        NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
        if ( statusCode != 200 )
        {
            NSString *errorMessage = [NSString stringWithFormat:@"HTTP error %d", (int)statusCode];
            NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : errorMessage };
            return [NSError errorWithDomain:@"test error domain"
                                       code:333
                                   userInfo:userInfo];
        }
    }

    return nil;
}

- (void)sendRequest:(NSURLRequest *)request ForTaskID:(int)taskID
{
    [[self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
      {
          if ( error )
          {
              dispatch_async(dispatch_get_main_queue(), ^{
                  [self.delegate connectionDidFailWithError:error TaskID:taskID];
              });
          }
          else
          {
              NSError *errorForResponse = [self errorForResponse:response];
              if (errorForResponse)
              {
                  dispatch_async(dispatch_get_main_queue(), ^{
                      [self.delegate connectionDidFailWithError:error TaskID:taskID];
                  });
              }
              else
              {
                  dispatch_async(dispatch_get_main_queue(), ^{
                      [self.delegate connectionServiceDidLoadData:data TaskID:taskID];
                  });
              }
          }
      }] resume];
}

- (void)loadDataFromURL:(NSURL *)url TaskID:(int)taskID
{
    if ( ![self.reachabilityManager isServerReachable] )
    {
        NSError *reachabilityError = [[NSError alloc] initWithDomain:@"reachabilityError domain" code:777 userInfo:@{NSLocalizedDescriptionKey : @"Сервер недоступен. Проверьте соединение с Интернетом."}];
        [self.delegate connectionDidFailWithError:reachabilityError TaskID:taskID];
    }
    else
    {
        [self sendRequest:[NSURLRequest requestWithURL:url] ForTaskID:taskID];
    }
};

- (void)stopAllTasks
{
    [self.session getAllTasksWithCompletionHandler:^(NSArray<__kindof NSURLSessionTask *> * _Nonnull tasks) {
        for (NSURLSessionTask *task in tasks) {
            [task cancel];
        }
    }];
}

@end

