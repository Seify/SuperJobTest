//
//  ShowVacanciesPageSubmoduleAsembler.m
//  SuperJob
//
//  Created by Roman S on 19.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import "ShowVacanciesPageSubmoduleAssembler.h"
#import "ShowVacanciesPageSubmoduleView.h"
#import "ShowVacanciesPageSubmoduleInteractor.h"
#import "ShowVacanciesPageSubmodulePresenter.h"
#import "ShowVacanciesPageSubmoduleRouter.h"

@implementation ShowVacanciesPageSubmoduleAssembler

+ (UIViewController *)submoduleWithRooterOutput:(id<ShowVacanciesPageSubmoduleRouterOutput>)routerOutput Data:(id)data Page:(int)page Keyword:(NSString *)keyword
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    ShowVacanciesPageSubmoduleView *view = [storyboard instantiateViewControllerWithIdentifier:@"ShowVacanciesPageSubmoduleView"];
    ShowVacanciesPageSubmodulePresenter *presenter = [[ShowVacanciesPageSubmodulePresenter alloc] init];
    ShowVacanciesPageSubmoduleInteractor *interactor = [[ShowVacanciesPageSubmoduleInteractor alloc] init];
    ShowVacanciesPageSubmoduleRouter *router = [[ShowVacanciesPageSubmoduleRouter alloc] init];
    view.output = presenter;
    presenter.view = view;
    presenter.interactor = interactor;
    presenter.router = router;
    interactor.output = presenter;
    router.output = routerOutput;
    
    return view;

};

@end