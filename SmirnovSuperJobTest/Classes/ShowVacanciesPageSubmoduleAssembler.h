//
//  ShowVacanciesPageSubmoduleAsembler.h
//  SuperJob
//
//  Created by Roman S on 19.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShowVacanciesPageSubmoduleRouter.h"
#import <UIKit/UIKit.h>

@interface ShowVacanciesPageSubmoduleAssembler : NSObject
+ (UIViewController *)submoduleWithRooterOutput:(id<ShowVacanciesPageSubmoduleRouterOutput>)routerOutput Data:(id)data Page:(int)page Keyword:(NSString *)keyword;
@end
