//
//  SearchVacancyModuleView.m
//  SuperJob
//
//  Created by Roman S on 14.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import "SearchVacancyModuleView.h"

@interface SearchVacancyModuleView ()

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)searchButtonPressed:(id)sender
{
    
}

- (void)showErrorMessage:(NSString *)errorMessage
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:errorMessage
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
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
