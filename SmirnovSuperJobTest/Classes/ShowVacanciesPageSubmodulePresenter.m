//
//  ShowVacanciesPageSubmodulePresenter.m
//  SuperJob
//
//  Created by Roman S on 19.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import "ShowVacanciesPageSubmodulePresenter.h"

@interface ShowVacanciesPageSubmodulePresenter()
@property NSString *keyword;
@property int page;
@property NSArray *vacancies;
@property BOOL viewLoaded;
@end

@implementation ShowVacanciesPageSubmodulePresenter

- (void)start
{
    if ( !self.vacancies )
    {
        [self.interactor requestVacanciesForKeyword:self.keyword Page:self.page];
    }
};

#pragma mark - ShowVacanciesPageSubmoduleViewOutput methods

- (void)viewDidLoad
{
    self.viewLoaded = YES;
    
    if ( self.vacancies )
    {
        [self.view showData:self.vacancies];
    }
    else
    {
        [self.view showSpinner];
    }
}

- (void)userDidSwipeLeft
{
    [self.router showPrevPageSubmodule];
};

- (void)userDidSwipeRight
{
    [self.router showNextPageSubmodule];
};

//- (void)userPressedOK
//{
//    
//};

#pragma mark - ShowVacanciesPageSubmoduleInteractorOutput methods

- (void)didLoadVacancies:(NSArray *)vacancies
{
    self.vacancies = vacancies;
    if ( self.viewLoaded )
    {
        [self.view showData:vacancies];
    }
};

- (void)didFailLoadVacanciesWithErrorMessage:(NSString *)errorMessage
{
    [self.view showErrorMessage:errorMessage];
};


@end
