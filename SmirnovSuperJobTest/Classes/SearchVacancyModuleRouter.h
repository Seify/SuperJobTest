//
//  SearchVacancyModuleRouter.h
//  SuperJob
//
//  Created by Roman S on 15.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SearchVacancyModuleRouterInput
- (void)presentNextModuleWithData:(id)data;
@end

@interface SearchVacancyModuleRouter : NSObject <SearchVacancyModuleRouterInput>
@end
