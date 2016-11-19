//
//  ShowVacanciesPageSubmoduleView.h
//  SuperJob
//
//  Created by Roman S on 19.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ShowVacanciesPageSubmoduleViewInput
@end

@protocol ShowVacanciesPageSubmoduleViewOutput
@end

@interface ShowVacanciesPageSubmoduleView : UIViewController<ShowVacanciesPageSubmoduleViewInput>
@property id<ShowVacanciesPageSubmoduleViewOutput>output;
@end
