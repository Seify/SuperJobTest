//
//  ConnectionService.h
//  SuperJob
//
//  Created by Roman S on 12.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ConnectionServiceDelegate;

@interface ConnectionService : NSObject
@property (weak) id<ConnectionServiceDelegate> delegate;
+(instancetype)sharedService;
- (void)loadDataFromURL:(NSURL *)url;
@end

@protocol ConnectionServiceDelegate
- (void)connectionServiceDidLoadData:(NSData *)data;
- (void)connectionDidFailWithError:(NSError *)error;
@end
