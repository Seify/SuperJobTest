//
//  ShowVacanciesModuleView.h
//  SuperJob
//
//  Created by Roman S on 16.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShowVacanciesModuleViewInput
@end

@protocol ShowVacanciesModuleViewOutput
- (void)viewDidLoad;
@end

@interface ShowVacanciesModuleView : UIPageViewController<ShowVacanciesModuleViewInput>
@property id<ShowVacanciesModuleViewOutput> output;
@end
