//
//  ShowVacanciesPageSubmoduleRouter.m
//  SuperJob
//
//  Created by Roman S on 19.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import "ShowVacanciesPageSubmoduleRouter.h"

@implementation ShowVacanciesPageSubmoduleRouter
- (void)showPrevModule
{
    [self.parentRouter routeToPrevModule];
}

- (void)showNextModuleWithVacancy:(id)vacancy
{
    [self.parentRouter routeToNextModuleWithVacancy:vacancy];
};

@end
