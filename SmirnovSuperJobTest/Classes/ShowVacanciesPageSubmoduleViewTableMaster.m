//
//  ShowVacanciesPageSubmoduleViewTableMaster.m
//  SuperJob
//
//  Created by Roman S on 19.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import "ShowVacanciesPageSubmoduleViewTableMaster.h"
#import "ShowVacanciesPageSubmoduleViewVacancyCell.h"
#import "VacancyModel.h"

@implementation ShowVacanciesPageSubmoduleViewTableMaster
- (void)reloadTable
{
    [self.tableView reloadData];
};

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.vacancies.count;
};

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShowVacanciesPageSubmoduleViewVacancyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShowVacanciesPageSubmoduleViewVacancyCell" forIndexPath:indexPath];
    
    VacancyModel *vacancy = self.vacancies[indexPath.row];
    cell.dateLabel.text = vacancy.date_published;
    cell.professionLabel.text = vacancy.profession;
    cell.compensationLabel.text = vacancy.compensation;
    cell.employerLabel.text = vacancy.firmName;

    return cell;
};

@end
