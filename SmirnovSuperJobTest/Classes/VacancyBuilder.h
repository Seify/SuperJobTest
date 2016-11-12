//
//  SuperJobVacancyBuilder.h
//  SuperJob
//
//  Created by Roman S on 12.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VacancyModel.h"

@interface VacancyBuilder : NSObject
+ (NSArray *)vacancyModelsFromJSON:(id<NSObject>)JSONData;
@end
