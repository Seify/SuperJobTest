//
//  testShowVacanciesPageSubmoduleViewTableMaster.m
//  SuperJob
//
//  Created by Roman S on 23.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "VacancyModel.h"
#import "ShowVacanciesPageSubmoduleViewTableMaster.h"
#import "ShowVacanciesPageSubmoduleViewVacancyCell.h"
#import "ShowVacanciesPageSubmoduleView.h"

@interface testShowVacanciesPageSubmoduleViewTableMaster : XCTestCase<ShowVacanciesPageSubmoduleViewTableMasterOutput>
@property ShowVacanciesPageSubmoduleViewTableMaster *tableMaster;
@property UITableView *tableView;
@property BOOL isVacancySelectedCalledOnOutput;
@end

@implementation testShowVacanciesPageSubmoduleViewTableMaster

#pragma mark - Setup

- (void)setUp
{
    [super setUp];
    self.tableMaster = [[ShowVacanciesPageSubmoduleViewTableMaster alloc] init];
    self.tableMaster.vacancies = [self testVacancies];
    UIStoryboard *s = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ShowVacanciesPageSubmoduleView *vc = [s instantiateViewControllerWithIdentifier:@"ShowVacanciesPageSubmoduleView"];
    self.tableView = vc.tableView;
    self.tableMaster.output = self;
}

- (void)tearDown
{
    self.isVacancySelectedCalledOnOutput = NO;
    self.tableMaster = nil;
    self.tableView = nil;
    [super tearDown];
}

#pragma mark - ShowVacanciesPageSubmoduleViewTableMasterOutput methods

- (void)didSelectVacancy:(VacancyModel *)vacancy
{
    self.isVacancySelectedCalledOnOutput = YES;
};

#pragma mark - Helpers

- (NSArray *)testVacancies
{
    VacancyModel *vm1   = [[VacancyModel alloc] init];
    vm1.date_published  = @"Сегодня";
    vm1.profession      = @"Философ";
    vm1.payment         = @"100500Р";
    vm1.firmName        = @"Кащенко";
    
    VacancyModel *vm2   = [[VacancyModel alloc] init];
    vm1.date_published  = @"Dec 31";
    vm1.profession      = @"Дед Мороз";
    vm1.payment         = @"0Р";
    vm1.firmName        = @"Полюс+";

    return @[vm1, vm2];
}

#pragma mark - Tests

- (void)testReturnsCorrectNumberOfRows
{
    //given
    
    //when
    
    //then
    XCTAssert( 2 == [self.tableMaster tableView:self.tableView numberOfRowsInSection:0] );
}

- (void)testReturnsCorrectCell
{
    //given
    VacancyModel *vm2 = [[self testVacancies] objectAtIndex:1];
    
    //when
    ShowVacanciesPageSubmoduleViewVacancyCell *cell = (ShowVacanciesPageSubmoduleViewVacancyCell *)[self.tableMaster tableView:self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    //then
    XCTAssertEqual(cell.professionLabel.text, vm2.profession);
    XCTAssertEqual(cell.dateLabel.text, vm2.date_published);
    XCTAssertEqual(cell.compensationLabel.text, vm2.payment);
    XCTAssertEqual(cell.employerLabel.text, vm2.firmName);
}

- (void)testNotifiesViewWhenCellSelected
{
    //given
    
    //when
    [self.tableMaster tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    //then
    XCTAssert(self.isVacancySelectedCalledOnOutput);
}

@end
