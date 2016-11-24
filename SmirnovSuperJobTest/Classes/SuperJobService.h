//
//  SuperJobService.h
//  SuperJob
//
//  Created by Roman S on 12.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SessionService.h"
#import "VacancyModel.h"

@protocol SuperJobServiceDelegate
- (void)didLoadPage:(VacanciesPageModel *)pageModel;
- (void)didFailLoadPageWithError:(NSError *)error;
@end

@protocol SuperJobServiceProtocol
- (void)loadPageForKeyword:(NSString *)keyword PageID:(int)pageID Delegate:(id<SuperJobServiceDelegate>)delegate;
- (void)cancelAllTasks;
@end

@interface SuperJobService : NSObject<SuperJobServiceProtocol, SessionServiceDelegate>
+ (instancetype)sharedService;
@end
