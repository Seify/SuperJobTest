//
//  ShowVacancyDetailsRouter.h
//  SuperJob
//
//  Created by Roman S on 24.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ShowVacancyDetailsModuleRouterInput
@end

@protocol ShowVacancyDetailsModuleRouterOutput
@end

@interface ShowVacancyDetailsModuleRouter : NSObject<ShowVacancyDetailsModuleRouterInput>
@property (weak) id<ShowVacancyDetailsModuleRouterOutput> output;
@property (weak) UINavigationController *rootController;
@end
