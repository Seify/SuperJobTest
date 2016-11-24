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
- (NSError *)errorForResponse:(NSURLResponse *)response;
@end


@implementation
SessionService

- (instancetype)initWithSession:(NSURLSession *)session
{
    if ( self = [super init] )
    {
        self.session = session;
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

- (void)loadDataFromURL:(NSURL *)url TaskID:(int)taskID
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
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

