//
//  ReachabilityManager.m
//  Little Chef
//
//  Created by Roman Smirnov on 14/11/15.
//  Copyright © 2015 7Apps. All rights reserved.
//

#import "ReachabilityManager.h"

@interface ReachabilityManager()
@property (nonatomic) Reachability *internetReachability;
@property NetworkStatus currentNetworkStatus;
@end

@implementation ReachabilityManager

+ (instancetype)sharedManager
{
    static ReachabilityManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    
    return sharedMyManager;
}

- (instancetype)init
{
    if ( self = [super init] )
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reachabilityChanged:)
                                                     name:kReachabilityChangedNotification
                                                   object:nil];

        self.internetReachability = [Reachability reachabilityWithHostName:@"https://api.superjob.ru"];
        self.currentNetworkStatus = [self.internetReachability currentReachabilityStatus];
        [self.internetReachability startNotifier];
    }
    
    return self;
}

- (void)reachabilityChanged:(NSNotification *)note
{
    Reachability* r = [note object];
    self.currentNetworkStatus = [r currentReachabilityStatus];
}

- (BOOL)isServerReachable
{
    return ( self.currentNetworkStatus != NotReachable );
}

@end
