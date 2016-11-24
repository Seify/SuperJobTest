//
//  ShowVacanciesModuleView.h
//  SuperJob
//
//  Created by Roman S on 16.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShowVacanciesModuleViewInput
- (void)showPageSubmodule:(UIViewController *)pageSubmodule;
@end

@protocol ShowVacanciesModuleViewOutput
- (void)viewDidLoad;
- (UIViewController *)pageSubmoduleViewBeforePageSubmoduleView:(UIViewController *)pageSubmoduleView;
- (UIViewController *)pageSubmoduleViewAfterPageSubmoduleView:(UIViewController *)pageSubmoduleView;
@end

@interface ShowVacanciesModuleView : UIPageViewController<ShowVacanciesModuleViewInput>
@property id<ShowVacanciesModuleViewOutput> output;
@end
