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
@property (weak) id<SuperJobServiceProtocol> service;
@end

@implementation ShowVacanciesPageSubmoduleInteractor

- (instancetype)init
{
    if ( self = [super init] )
    {
        self.service = [SuperJobService sharedService];
    }
    
    return self;
}

- (void)requestPageForKeyword:(NSString *)keyword PageID:(int)pageID
{
    if ( keyword.length == 0 )
    {
        [self.output didFailLoadPageWithErrorMessage:@"Empty keyword."];
        return;
    }
    
    if ( pageID < 0 )
    {
        [self.output didFailLoadPageWithErrorMessage:@"Wrong page."];
        return;
    }
    
    [self.service loadPageForKeyword:keyword PageID:pageID Delegate:self];
};

#pragma mark - SuperJobServiceDelegate methods

- (void)didLoadPage:(VacanciesPageModel *)page
{
    [self.output didLoadPage:page];
};

- (void)didFailLoadPageWithError:(NSError *)error
{
    [self.output didFailLoadPageWithErrorMessage:error.localizedDescription];
};

@end
