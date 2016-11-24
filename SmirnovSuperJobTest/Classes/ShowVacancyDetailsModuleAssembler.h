//
//  ShowVacancyDetailsAssembler.h
//  SuperJob
//
//  Created by Roman S on 24.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VacancyModel.h"
#import <UIKit/UIKit.h>

@interface ShowVacancyDetailsModuleAssembler : NSObject
+ (UIViewController *)moduleWithRootController:(UINavigationController *)rootController Vacancy:(VacancyModel *)vacancy;
@end
