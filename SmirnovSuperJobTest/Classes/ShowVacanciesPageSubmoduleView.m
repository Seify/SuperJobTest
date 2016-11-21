//
//  ShowVacanciesPageSubmoduleView.m
//  SuperJob
//
//  Created by Roman S on 19.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import "ShowVacanciesPageSubmoduleView.h"

@implementation ShowVacanciesPageSubmoduleView

@synthesize tableMaster = _tableMaster;

- (ShowVacanciesPageSubmoduleViewTableMaster *)tableMaster
{
    if ( !_tableMaster )
    {
        _tableMaster = [[ShowVacanciesPageSubmoduleViewTableMaster alloc] init];
        _tableMaster.tableView = self.tableView;
    }
    return _tableMaster;
}

- (void)viewDidLoad
{
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

- (void)showData:(id)data
{
    self.tableMaster.vacancies = data;
    [self.tableMaster reloadTable];
};

- (void)showErrorMessage:(NSString *)message
{
    
};

@end
