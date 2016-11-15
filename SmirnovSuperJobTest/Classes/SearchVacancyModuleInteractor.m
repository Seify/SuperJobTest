//
//  SearchVacancyModuleInteractor.m
//  SuperJob
//
//  Created by Roman S on 14.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import "SearchVacancyModuleInteractor.h"
#import "SuperJobService.h"

@interface SearchVacancyModuleInteractor()<SuperJobServiceDelegate>
@end

@implementation SearchVacancyModuleInteractor

- (void)loadVacanciesForKeyword:(NSString *)keyword
{
    if ( keyword.length == 0 )
    {
        [self.output didFailLoadVacanciesWithErrorMessage:@"Empty keyword."];
    }
    else
    {
        SuperJobService *service = [SuperJobService sharedService];
        service.delegate = self;
        [service loadVacanciesForKeyword:keyword];
    }
}

#pragma mark - SuperJobServiceDelegate methods

- (void)didLoadVacancies:(NSArray *)vacancies
{
    [self.output didLoadVacancies:vacancies];
};

- (void)didFailLoadVacanciesWithError:(NSError *)error
{
    
};

@end
