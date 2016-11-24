//
//  SuperJobVacancyBuilder.h
//  SuperJob
//
//  Created by Roman S on 12.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VacancyModel.h"

@protocol VacancyBuilderProtocol
+ (VacanciesPageModel *)pageFromJSON:(NSDictionary *)JSONDict PageID:(int)pageID Keyword:(NSString *)keyword Error:(NSError **)error;
@end

@interface VacancyBuilder : NSObject<VacancyBuilderProtocol>
@end
