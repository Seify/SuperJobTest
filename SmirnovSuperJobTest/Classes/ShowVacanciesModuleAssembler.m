//
//  ShowVacanciesModuleAssembler.m
//  SuperJob
//
//  Created by Roman S on 16.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import "ShowVacanciesModuleAssembler.h"
#import "ShowVacanciesModuleView.h"
#import "ShowVacanciesModuleInteractor.h"
#import "ShowVacanciesModulePresenter.h"
#import "ShowVacanciesModuleRouter.h"

@implementation ShowVacanciesModuleAssembler

+ (UIViewController *)moduleWithRootController:(UINavigationController *)rootController Keyword:(NSString *)keyword
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    ShowVacanciesModuleView *view = [storyboard instantiateViewControllerWithIdentifier:@"ShowVacanciesModuleView"];
    ShowVacanciesModulePresenter *presenter = [[ShowVacanciesModulePresenter alloc] init];
    ShowVacanciesModuleInteractor *interactor = [[ShowVacanciesModuleInteractor alloc] init];
    ShowVacanciesModuleRouter *router = [[ShowVacanciesModuleRouter alloc] init];
    view.output = presenter;
    presenter.view = view;
    presenter.interactor = interactor;
    presenter.router = router;
    interactor.output = presenter;
    router.rootController = rootController;
    
    [presenter startWithKeyword:keyword];
    
    return view;
};

@end
