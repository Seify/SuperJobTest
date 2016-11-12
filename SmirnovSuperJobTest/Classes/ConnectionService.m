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
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        if ( !error )
        {
            [self.delegate connectionServiceDidLoadData:data];
        }
        else
        {
            NSLog(@"%@ : %@ %@", [self class], NSStringFromSelector(_cmd), [error localizedDescription]);
            [self.delegate connectionServiceDidFailLoadData];
        }
        
    }] resume];
    

};

@end

