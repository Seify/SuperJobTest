//
//  SearchVacancyModulePresenter.m
//  SuperJob
//
//  Created by Roman S on 14.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import "SearchVacancyModulePresenter.h"

@interface SearchVacancyModulePresenter()
@property BOOL viewDidLoad;
@end

@implementation SearchVacancyModulePresenter

#pragma mark - SearchVacancyModuleViewOutput methods

- (void)didLoad
{
    self.viewDidLoad = YES;
};

- (void)searchPressedForEnteredKeyword:(NSString *)keyword
{
    if ( [self.interactor isGoodKeyword:keyword] )
    {
        [self.router presentNextModuleWithKeyword:keyword];
    }
    else
    {
        [self.view showErrorMessage:@"Try another keyword."];
    };
};

- (void)errorOkPressed
{
    [self.view dismissErrorMessage];
};

@end
