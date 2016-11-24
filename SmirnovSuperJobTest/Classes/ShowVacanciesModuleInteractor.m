//
//  ShowVacanciesModuleInteractor.m
//  SuperJob
//
//  Created by Roman S on 16.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import "ShowVacanciesModuleInteractor.h"
#import "SuperJobService.h"

@interface ShowVacanciesModuleInteractor()
@property id<SuperJobServiceProtocol> service;
@end

@implementation ShowVacanciesModuleInteractor

- (instancetype)init
{
    if ( self = [super init] )
    {
        self.service = [SuperJobService sharedService];
    }
    
    return self;
}

#pragma mark - ShowVacanciesModuleInteractorInput methods

- (void)stopAllTasks
{
    [self.service cancelAllTasks];
}

@end
