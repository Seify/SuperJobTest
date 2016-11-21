//
//  ShowVacanciesPageSubmoduleRouter.h
//  SuperJob
//
//  Created by Roman S on 19.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ShowVacanciesPageSubmoduleRouterInput
- (void)showPrevPageSubmodule;
- (void)showNextPageSubmodule;
- (void)showNextModule;
@end

@protocol ShowVacanciesPageSubmoduleRouterOutput
@end

@interface ShowVacanciesPageSubmoduleRouter : NSObject<ShowVacanciesPageSubmoduleRouterInput>
@property (weak) id<ShowVacanciesPageSubmoduleRouterOutput> output;
@end
