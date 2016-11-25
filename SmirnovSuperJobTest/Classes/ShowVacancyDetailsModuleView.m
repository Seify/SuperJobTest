//
//  ShowVacancyDetailsView.m
//  SuperJob
//
//  Created by Roman S on 24.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import "ShowVacancyDetailsModuleView.h"

@interface ShowVacancyDetailsModuleView ()

@end

@implementation ShowVacancyDetailsModuleView

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.output viewDidLoad];
}

#pragma mark - ShowVacancyDetailsModuleViewInput methods

- (void)showVacancyDetails:(VacancyModel *)vm
{
    self.dateLabel.text = vm.date_published;
    self.paymentLabel.text = vm.payment;
    self.professionLabel.text = vm.profession;
    self.townLabel.text = vm.townName;
    self.compensationLabel.text = vm.compensation;
    self.experienceLabel.text = vm.experienceName;
    self.educationLabel.text = vm.educationName;
};

@end
