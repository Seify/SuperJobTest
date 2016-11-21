//
//  ShowVacanciesPageSubmoduleInteractor.m
//  SuperJob
//
//  Created by Roman S on 19.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import "ShowVacanciesPageSubmoduleInteractor.h"
#import "SuperJobService.h"

@interface ShowVacanciesPageSubmoduleInteractor()<SuperJobServiceDelegate>

@end

@implementation ShowVacanciesPageSubmoduleInteractor

- (void)requestVacanciesForKeyword:(NSString *)keyword Page:(int)page
{
    if ( keyword.length == 0 )
    {
        [self.output didFailLoadVacanciesWithErrorMessage:@"Empty keyword."];
        return;
    }
    
    if ( page < 0 )
    {
        [self.output didFailLoadVacanciesWithErrorMessage:@"Wrong page."];
        return;
    }
    
    SuperJobService *service = [SuperJobService sharedService];
    service.delegate = self;
    [service loadVacanciesForKeyword:keyword Page:page];
};

#pragma mark - SuperJobServiceDelegate methods

- (void)didLoadVacancies:(NSArray *)vacancies
{
    [self.output didLoadVacancies:vacancies];
};

- (void)didFailLoadVacanciesWithError:(NSError *)error
{
    [self.output didFailLoadVacanciesWithErrorMessage:error.localizedDescription];
};

@end
