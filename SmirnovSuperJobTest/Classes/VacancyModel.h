//
//  SuperJobVacancyModel.h
//  SuperJob
//
//  Created by Roman S on 12.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <Foundation/Foundation.h>

// https://api.superjob.ru/#search_vacanices

@interface VacancyModel : NSObject
@property NSString *profession;
@property NSString *work;
@property NSString *compensation;
@property NSString *address;
@property NSString *townName;
@property NSString *educationName;
@property NSString *experienceName;
@property NSDate *date_published;
@end
