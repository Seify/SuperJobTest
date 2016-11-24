//
//  ShowVacanciesModuleRouter.m
//  SuperJob
//
//  Created by Roman S on 16.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import "ShowVacanciesModuleRouter.h"
#import "ShowVacanciesPageSubmoduleAssembler.h"
#import "ShowVacanciesPageSubmoduleView.h"

@interface ShowVacanciesModuleRouter()
@property NSMutableArray *submodules;
@property Class submoduleAssemblerClass;
@end

@implementation ShowVacanciesModuleRouter

- (instancetype)init
{
    if ( self = [super init] )
    {
        self.submodules = [NSMutableArray array];
        self.submoduleAssemblerClass = [ShowVacanciesPageSubmoduleAssembler class];
    }
    return self;
}

- (UIViewController *)pageSubmoduleWithPage:(int)page Keyword:(NSString *)keyword
{
    UIViewController *pageSubmoduleView = [self.submoduleAssemblerClass submoduleWithParentRouter:self Page:page Keyword:keyword];
    [self.submodules addObject:pageSubmoduleView];
    return pageSubmoduleView;
};

- (UIViewController *)pageSubmoduleViewBeforePageSubmoduleView:(id<ShowVacanciesPageSubmoduleViewInput>)pageSubmoduleView
{
    if ( pageSubmoduleView.page.pageID > 0 )
    {
        return self.submodules[pageSubmoduleView.page.pageID - 1];
    }
    return nil;
};

- (UIViewController *)pageSubmoduleViewAfterPageSubmoduleView:(id<ShowVacanciesPageSubmoduleViewInput>)pageSubmoduleView
{
    if ( pageSubmoduleView.page.hasMore )
    {
        if ( self.submodules.count > pageSubmoduleView.page.pageID + 1 )
        {
            return self.submodules[pageSubmoduleView.page.pageID + 1];
        }
        UIViewController *nextPage = [self.submoduleAssemblerClass submoduleWithParentRouter:self Page:pageSubmoduleView.page.pageID + 1 Keyword:pageSubmoduleView.page.keyword];
        [self.submodules addObject:nextPage];
        return nextPage;
    }
    return nil;
};

- (void)routeToPrevModule
{
    [self.output willRouteToPrevModule];
    [self.rootController popViewControllerAnimated:YES];
};

- (void)routeToNextModuleWithVacancy:(id)vacancy
{
#warning Realize this!
};

@end
