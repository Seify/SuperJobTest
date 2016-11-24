//
//  ReachabilityManager.h
//  Little Chef
//
//  Created by Roman Smirnov on 14/11/15.
//  Copyright © 2015 7Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@protocol ReachabilityManagerProtocol
- (BOOL)isServerReachable;
@end

@interface ReachabilityManager : NSObject<ReachabilityManagerProtocol>
+ (instancetype)sharedManager;
@end
