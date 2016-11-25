//
//  ShowVacanciesPageSubmoduleViewTableMaster.m
//  SuperJob
//
//  Created by Roman S on 19.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import "ShowVacanciesPageSubmoduleViewTableMaster.h"
#import "ShowVacanciesPageSubmoduleViewVacancyCell.h"

@implementation ShowVacanciesPageSubmoduleViewTableMaster

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.vacancies.count;
};

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShowVacanciesPageSubmoduleViewVacancyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShowVacanciesPageSubmoduleViewVacancyCell" forIndexPath:indexPath];
    
    VacancyModel *vacancy = self.vacancies[indexPath.row];
    cell.dateLabel.text = vacancy.date_published;
    cell.professionLabel.text = vacancy.profession;
    cell.compensationLabel.text = vacancy.payment;
    cell.employerLabel.text = vacancy.firmName;

    return cell;
};

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.output didSelectVacancy:self.vacancies[indexPath.row]];
}

@end
