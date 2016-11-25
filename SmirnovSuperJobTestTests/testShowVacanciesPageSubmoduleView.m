//
//  testShowVacanciesPageSubmoduleView.m
//  SuperJob
//
//  Created by Roman S on 19.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ShowVacanciesPageSubmoduleView.h"
#import "VacancyModel.h"
#import "ShowVacanciesPageSubmoduleViewVacancyCell.h"

@interface ShowVacanciesPageSubmoduleView()
@property (weak) UIAlertController *alert;
@end

@interface testShowVacanciesPageSubmoduleView : XCTestCase <ShowVacanciesPageSubmoduleViewOutput>
@property BOOL didLoadCalled;
@property ShowVacanciesPageSubmoduleView *view;
@property NSArray *vacancies;
@end

@implementation testShowVacanciesPageSubmoduleView

#pragma mark - Setup

- (void)setUp
{
    [super setUp];
    UIStoryboard *s = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.view = [s instantiateViewControllerWithIdentifier:@"ShowVacanciesPageSubmoduleView"];
    self.view.output = self;
    self.view.tableMaster = (ShowVacanciesPageSubmoduleViewTableMaster *)self;
    [self.view view]; //calls viewDidLoad
    [self waitForDidLoad:2];
}

- (void)tearDown
{
    self.view = nil;
    self.didLoadCalled = NO;
    self.vacancies = nil;
    [super tearDown];
}

#pragma mark - ShowVacanciesPageSubmoduleViewTableMaster methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
};

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - ShowVacanciesModuleViewOutput methods

- (void)viewDidLoad
{
    self.didLoadCalled = YES;
}

- (void)errorOkPressed
{
    
};

#pragma mark - Helpers

- (BOOL)waitForDidLoad:(NSTimeInterval)timeoutSecs
{
    NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:timeoutSecs];
    
    do {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:timeoutDate];
        if([timeoutDate timeIntervalSinceNow] < 0.0)
        {
            break;
        }
    } while ( !self.didLoadCalled );
    
    return self.didLoadCalled;
}

#pragma mark - Tests

- (void)testNotifiesPresenterOnLoad
{
    //given
    
    //when
    
    //then
    XCTAssertTrue(self.didLoadCalled);
}

- (void)testAnimatesSpinner
{
    //given

    //when
    [self.view showSpinner];
    
    //then
    XCTAssert(self.view.spinner.animating);
}

- (void)testStopsAnimatingSpinner
{
    //given
    
    //when
    [self.view showSpinner];
    [self.view hideSpinner];
    
    //then
    XCTAssertFalse(self.view.spinner.animating);
}

- (void)testPassesDataToTableMaster
{
    //given
    VacanciesPageModel *page = [[VacanciesPageModel alloc] init];
    page.vacancies = @[];
    
    //when
    [self.view showPage:page];
    
    //then
    XCTAssert(self.vacancies == page.vacancies );
}

- (void)testErrorMessageStringIsCorrect
{
    //given
    NSString *errorMessage = @"Some error";
    
    //when
    [self.view showErrorMessage:errorMessage];
    
    //then
    XCTAssert([errorMessage isEqualToString:self.view.alert.message]);
}

- (void)testErrorMessageDismissal
{
    //given
    NSString *errorMessage = @"Empty keyword";
    [self.view showErrorMessage:errorMessage];
    
    //when
    [self.view dismissErrorMessage];
    
    //then
    XCTAssertNil(self.view.alert);
}

@end
