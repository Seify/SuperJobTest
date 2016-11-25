//
//  ShowVacanciesPageSubmodulePresenter.m
//  SuperJob
//
//  Created by Roman S on 19.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import "ShowVacanciesPageSubmodulePresenter.h"

@interface ShowVacanciesPageSubmodulePresenter()
@property BOOL viewLoaded;
@property NSString *errorMessage;
@end

@implementation ShowVacanciesPageSubmodulePresenter

- (void)startWithPageID:(int)pageID Keyword:(NSString *)keyword
{
    [self.interactor requestPageForKeyword:keyword PageID:pageID];
};

#pragma mark - ShowVacanciesPageSubmoduleViewOutput methods

- (void)viewDidLoad
{
    self.viewLoaded = YES;
    
    if ( self.errorMessage )
    {
        [self.view showErrorMessage:self.errorMessage];
        self.errorMessage = nil;
    }
    else if ( self.page )
    {
        [self.view showPage:self.page];
        [self.view hideSpinner];
    }
    else
    {
        [self.view showSpinner];
    }
}

- (void)errorOkPressed
{
    [self.view dismissErrorMessage];
    [self.router showPrevModule];
}

#pragma mark - ShowVacanciesPageSubmoduleInteractorOutput methods

- (void)didLoadPage:(VacanciesPageModel *)page
{
    NSAssert(page, @"nil page!");
    
    self.page = page;
    if ( self.viewLoaded )
    {
        [self.view showPage:page];
        [self.view hideSpinner];
    }
};

- (void)didFailLoadPageWithErrorMessage:(NSString *)errorMessage;
{
    if ( self.viewLoaded )
    {
        [self.view showErrorMessage:errorMessage];
    }
    else
    {
        self.errorMessage = errorMessage;
    }
};

#pragma mark - ShowVacanciesPageSubmoduleViewTableMasterOutput methods

- (void)didSelectVacancy:(VacancyModel *)vacancy
{
    [self.router showNextModuleWithVacancy:vacancy];
}

@end
