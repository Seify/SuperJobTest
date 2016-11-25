//
//  ShowVacanciesPageSubmoduleViewTableMaster.h
//  SuperJob
//
//  Created by Roman S on 19.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VacancyModel.h"

@protocol ShowVacanciesPageSubmoduleViewTableMasterOutput
- (void)didSelectVacancy:(VacancyModel *)vacancy;
@end

@interface ShowVacanciesPageSubmoduleViewTableMaster : NSObject<UITableViewDelegate, UITableViewDataSource>
@property id<ShowVacanciesPageSubmoduleViewTableMasterOutput> output;
@property NSArray *vacancies;
@end
