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
@property NSString *payment;
@property NSString *address;
@property NSString *townName;
@property NSString *educationName;
@property NSString *experienceName;
@property NSString *date_published;
@property NSString *firmName;
@end

@interface VacanciesPageModel : NSObject
@property NSArray *vacancies;
@property int pageID;
@property NSString *keyword;
@property BOOL hasMore;
@end
