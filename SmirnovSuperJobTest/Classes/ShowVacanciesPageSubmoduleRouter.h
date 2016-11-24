//
//  ShowVacanciesPageSubmoduleRouter.h
//  SuperJob
//
//  Created by Roman S on 19.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShowVacanciesModuleRouter.h"

@protocol ShowVacanciesPageSubmoduleRouterInput
- (void)showNextModuleWithVacancy:(id)vacancy;
- (void)showPrevModule;
@end

@protocol ShowVacanciesPageSubmoduleRouterOutput
@end

@interface ShowVacanciesPageSubmoduleRouter : NSObject<ShowVacanciesPageSubmoduleRouterInput>
@property (weak) id<ShowVacanciesPageSubmoduleRouterOutput> output;
@property (weak) id<ShowVacanciesModuleRouterInput> parentRouter;
@end
