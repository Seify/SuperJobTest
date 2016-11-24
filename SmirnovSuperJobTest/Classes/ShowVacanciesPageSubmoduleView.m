//
//  ShowVacanciesPageSubmoduleView.m
//  SuperJob
//
//  Created by Roman S on 19.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import "ShowVacanciesPageSubmoduleView.h"

@interface ShowVacanciesPageSubmoduleView()
@property (weak) UIAlertController *alert;
@property ShowVacanciesPageSubmoduleViewTableMaster *tableMaster;
@end

@implementation ShowVacanciesPageSubmoduleView


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        self.tableMaster = [[ShowVacanciesPageSubmoduleViewTableMaster alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    self.tableView.delegate = self.tableMaster;
    self.tableView.dataSource = self.tableMaster;

    [self.output viewDidLoad];
}

#pragma mark - ShowVacanciesPageSubmoduleViewInput methods

- (void)showSpinner
{
    [self.spinner startAnimating];
};

- (void)hideSpinner
{
    [self.spinner stopAnimating];
};

- (void)showPage:(VacanciesPageModel *)page
{
    self.page = page;
    self.tableMaster.vacancies = page.vacancies;
    [self.tableView reloadData];
};

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
