//
//  SearchVacancyModuleRouter.m
//  SuperJob
//
//  Created by Roman S on 15.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import "SearchVacancyModuleRouter.h"
#import "ShowVacanciesModuleAssembler.h"

@implementation SearchVacancyModuleRouter

- (void)presentNextModuleWithKeyword:(NSString *)keyword
{
    UIViewController *showVacanciesModule = [ShowVacanciesModuleAssembler moduleWithRootController:self.rootController Keyword:keyword];
    [self.rootController pushViewController:showVacanciesModule animated:YES];
};

@end
