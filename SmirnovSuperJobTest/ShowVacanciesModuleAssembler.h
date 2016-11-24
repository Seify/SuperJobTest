//
//  ShowVacanciesModuleAssembler.h
//  SuperJob
//
//  Created by Roman S on 16.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ShowVacanciesModuleAssembler : NSObject

+ (UIViewController *)moduleWithRootController:(UIViewController *)rootController Keyword:(NSString *)keyword;

@end
