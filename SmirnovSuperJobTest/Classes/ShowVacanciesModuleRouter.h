//
//  ShowVacanciesModuleRouter.h
//  SuperJob
//
//  Created by Roman S on 16.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ShowVacanciesModuleRouterInput
- (UIViewController *)pageSubmoduleWithPage:(int)page Keyword:(NSString *)keyword;
- (UIViewController *)pageSubmoduleViewBeforePageSubmoduleView:(UIViewController *)pageSubmoduleView;
- (UIViewController *)pageSubmoduleViewAfterPageSubmoduleView:(UIViewController *)pageSubmoduleView;
- (void)routeToPrevModule;
- (void)routeToNextModuleWithVacancy:(id)vacancy;
@end

@protocol ShowVacanciesModuleRouterOutput
- (void)willRouteToPrevModule;
@end

@interface ShowVacanciesModuleRouter : NSObject<ShowVacanciesModuleRouterInput>
@property (weak) id<ShowVacanciesModuleRouterOutput> output;
@property (weak) UINavigationController *rootController;

@end
