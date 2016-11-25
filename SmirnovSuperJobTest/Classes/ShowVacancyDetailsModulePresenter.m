//
//  ShowVacancyDetailsPresenter.m
//  SuperJob
//
//  Created by Roman S on 24.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import "ShowVacancyDetailsModulePresenter.h"

@interface ShowVacancyDetailsModulePresenter()
@property BOOL viewLoaded;
@end

@implementation ShowVacancyDetailsModulePresenter

- (void)viewDidLoad
{
    [self.view showVacancyDetails:self.vacancy];
}

@end
