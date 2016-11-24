//
//  SearchVacancyModuleView.m
//  SuperJob
//
//  Created by Roman S on 14.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import "SearchVacancyModuleView.h"

@interface SearchVacancyModuleView ()
@property (weak) UIAlertController *alert;
@end

@implementation SearchVacancyModuleView

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.output didLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchButtonPressed:(id)sender
{
    [self.output searchPressedForEnteredKeyword:self.searchField.text];
}

- (void)showErrorMessage:(NSString *)errorMessage
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:errorMessage
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK"
                                                 style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action)
                         {
                             [self.output errorOkPressed];
                         }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
    self.alert = alert;
};

- (void)dismissErrorMessage
{
    [self dismissViewControllerAnimated:YES completion:nil];
    self.alert = nil;
};

@end
