//
//  SuperJobService.h
//  SuperJob
//
//  Created by Roman S on 12.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConnectionService.h"

@protocol SuperJobServiceDelegate;

@interface SuperJobService : NSObject<ConnectionServiceDelegate>
@property (weak) id<SuperJobServiceDelegate> delegate;
+ (instancetype)sharedService;
- (void)loadVacanciesForKeyword:(NSString *)keyword;
- (void)loadVacanciesForKeyword:(NSString *)keyword Page:(int)page;
@end

@protocol SuperJobServiceDelegate
- (void)didLoadVacancies:(NSArray *)vacancies;
- (void)didFailLoadVacanciesWithError:(NSError *)error;
@end

