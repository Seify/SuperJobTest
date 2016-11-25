//
//  ShowVacancyDetailsView.h
//  SuperJob
//
//  Created by Roman S on 24.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VacancyModel.h"

@protocol ShowVacancyDetailsModuleViewInput
- (void)showVacancyDetails:(VacancyModel *)vacancy;
@end

@protocol ShowVacancyDetailsModuleViewOutput
- (void)viewDidLoad;
@end

@interface ShowVacancyDetailsModuleView : UIViewController<ShowVacancyDetailsModuleViewInput>
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *paymentLabel;
@property (weak, nonatomic) IBOutlet UILabel *professionLabel;
@property (weak, nonatomic) IBOutlet UILabel *townLabel;
@property (weak, nonatomic) IBOutlet UILabel *compensationLabel;
@property (weak, nonatomic) IBOutlet UILabel *experienceLabel;
@property (weak, nonatomic) IBOutlet UILabel *educationLabel;
@property id<ShowVacancyDetailsModuleViewOutput>output;
@end
