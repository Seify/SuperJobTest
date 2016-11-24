//
//  ConnectionService.h
//  SuperJob
//
//  Created by Roman S on 12.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SessionServiceDelegate
- (void)connectionServiceDidLoadData:(NSData *)data TaskID:(NSUInteger)taskID;
- (void)connectionDidFailWithError:(NSError *)error TaskID:(NSUInteger)taskID;
@end

@protocol SessionServiceProtocol
@property (weak) id<SessionServiceDelegate> delegate;
- (void)loadDataFromURL:(NSURL *)url TaskID:(int)taskID;
- (void)stopAllTasks;
@end

@interface SessionService : NSObject <SessionServiceProtocol>
@property (weak) id<SessionServiceDelegate> delegate;
- (instancetype)initWithSession:(NSURLSession *)session;
@end
