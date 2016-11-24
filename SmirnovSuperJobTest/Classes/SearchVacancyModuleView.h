//
//  SearchVacancyModuleView.h
//  SuperJob
//
//  Created by Roman S on 14.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchVacancyModuleViewInput
- (void)showErrorMessage:(NSString *)errorMessage;
- (void)dismissErrorMessage;
@end

@protocol SearchVacancyModuleViewOutput
- (void)didLoad;
- (void)searchPressedForEnteredKeyword:(NSString *)keyword;
- (void)errorOkPressed;
@end

@interface SearchVacancyModuleView : UIViewController <SearchVacancyModuleViewInput>
@property id<SearchVacancyModuleViewOutput> output;
@property (weak, nonatomic) IBOutlet UITextField *searchField;
- (IBAction)searchButtonPressed:(id)sender;
@end
