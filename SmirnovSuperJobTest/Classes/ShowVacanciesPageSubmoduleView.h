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

@protocol ShowVacanciesPageSubmoduleViewInput
- (void)showSpinner;
- (void)hideSpinner;
- (void)showData:(id)data;
@end

@protocol ShowVacanciesPageSubmoduleViewOutput
- (void)viewDidLoad;
@end

@interface ShowVacanciesPageSubmoduleView : UIViewController<ShowVacanciesPageSubmoduleViewInput>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property id<ShowVacanciesPageSubmoduleViewOutput>output;
@property (readonly) ShowVacanciesPageSubmoduleViewTableMaster *tableMaster;
@end
