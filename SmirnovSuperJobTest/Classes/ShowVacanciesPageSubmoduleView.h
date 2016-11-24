//
//  ShowVacanciesPageSubmoduleView.h
//  SuperJob
//
//  Created by Roman S on 19.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShowVacanciesPageSubmoduleViewTableMaster.h"
#import <UIKit/UIKit.h>
#import "VacancyModel.h"

@protocol ShowVacanciesPageSubmoduleViewInput
@property VacanciesPageModel *page;
- (void)showSpinner;
- (void)hideSpinner;
- (void)showPage:(id)data;
- (void)showErrorMessage:(NSString *)message;
- (void)dismissErrorMessage;
@end

@protocol ShowVacanciesPageSubmoduleViewOutput
- (void)viewDidLoad;
- (void)errorOkPressed;
@end

@interface ShowVacanciesPageSubmoduleView : UIViewController<ShowVacanciesPageSubmoduleViewInput>
@property VacanciesPageModel *page;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property id<ShowVacanciesPageSubmoduleViewOutput>output;
@end
