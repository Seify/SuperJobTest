//
//  ConnectionService.m
//  SuperJob
//
//  Created by Roman S on 12.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import "ConnectionService.h"

@implementation ConnectionService

+(instancetype)sharedService
{
    static ConnectionService *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[ConnectionService alloc] init];
    });

    return _sharedInstance;
};

- (void)loadDataFromURL:(NSURL *)url
{
    NSAssert( self.delegate, @"No delegate!" );
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.HTTPAdditionalHeaders = @{
                                                   @"X-Api-App-Id" : @"v1.r0764bb4369e723b9d84160bb38d2718b2efb53d7f6400dbcb46f81e8737eb5c4b826437e.3b1f5943602b514b61c078194bed419ed1057f8f"
                                                   };
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        if ( !error )
        {
            [self.delegate connectionServiceDidLoadData:data];
        }
        else
        {
            [self.delegate connectionDidFailWithError:error];
        }
        
    }] resume];
    

};

@end

