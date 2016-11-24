//
//  ShowVacanciesModulePresenter.m
//  SuperJob
//
//  Created by Roman S on 16.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import "ShowVacanciesModulePresenter.h"
#import "ShowVacanciesPageSubmoduleView.h"

@interface ShowVacanciesModulePresenter()
@property BOOL viewLoaded;
@property NSString *keyword;
@end

@implementation ShowVacanciesModulePresenter

- (void)startWithKeyword:(NSString *)keyword
{
    self.keyword = keyword;
};

#pragma mark - ShowVacanciesModuleViewOutput methods

- (void)viewDidLoad
{
    self.viewLoaded = YES;
    id firstPage = [self.router pageSubmoduleWithPage:0 Keyword:self.keyword];
    [self.view showPageSubmodule:firstPage];
}

- (UIViewController *)pageSubmoduleViewBeforePageSubmoduleView:(UIViewController *)pageSubmoduleView
{
    return [self.router pageSubmoduleViewBeforePageSubmoduleView:pageSubmoduleView];
};

- (UIViewController *)pageSubmoduleViewAfterPageSubmoduleView:(UIViewController *)pageSubmoduleView
{
    return [self.router pageSubmoduleViewAfterPageSubmoduleView:pageSubmoduleView];
};

- (void)willRouteToPrevModule
{
    [self.interactor stopAllTasks];
}

@end
