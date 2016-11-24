//
//  ShowVacanciesModuleView.m
//  SuperJob
//
//  Created by Roman S on 16.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import "ShowVacanciesModuleView.h"

@interface ShowVacanciesModuleView ()<UIPageViewControllerDataSource>
@end

@implementation ShowVacanciesModuleView

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataSource = self;
    
    [self.output viewDidLoad];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ShowVacanciesModuleViewInput methods

- (void)showPageSubmodule:(UIViewController *)pageSubmodule
{
    [self setViewControllers:@[pageSubmodule] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
};

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    return [self.output pageSubmoduleViewBeforePageSubmoduleView:viewController];
};

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    return [self.output pageSubmoduleViewAfterPageSubmoduleView:viewController];
};

@end
