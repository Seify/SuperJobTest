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
@end

@protocol ShowVacanciesModuleRouterOutput
@end


@interface ShowVacanciesModuleRouter : NSObject<ShowVacanciesModuleRouterInput>
@property (weak) id<ShowVacanciesModuleRouterOutput> output;
@property (weak) UIViewController *rootController;
@end
