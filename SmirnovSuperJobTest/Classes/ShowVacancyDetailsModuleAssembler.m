//
//  ShowVacancyDetailsAssembler.m
//  SuperJob
//
//  Created by Roman S on 24.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import "ShowVacancyDetailsModuleAssembler.h"
#import "ShowVacancyDetailsModuleView.h"
#import "ShowVacancyDetailsModuleInteractor.h"
#import "ShowVacancyDetailsModulePresenter.h"
#import "ShowVacancyDetailsModuleRouter.h"

@implementation ShowVacancyDetailsModuleAssembler

+ (UIViewController *)moduleWithRootController:(UINavigationController *)rootController Vacancy:(VacancyModel *)vacancy
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    ShowVacancyDetailsModuleView *view = [storyboard instantiateViewControllerWithIdentifier:@"ShowVacancyDetailsModuleView"];
    ShowVacancyDetailsModulePresenter *presenter = [[ShowVacancyDetailsModulePresenter alloc] init];
    ShowVacancyDetailsModuleInteractor *interactor = [[ShowVacancyDetailsModuleInteractor alloc] init];
    ShowVacancyDetailsModuleRouter *router = [[ShowVacancyDetailsModuleRouter alloc] init];
    view.output = presenter;
    presenter.view = view;
    presenter.interactor = interactor;
    presenter.router = router;
    presenter.vacancy = vacancy;
    interactor.output = presenter;
    router.rootController = rootController;
    
    return view;
};

@end
