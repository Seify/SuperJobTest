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

@interface testShowVacanciesPageSubmoduleView : XCTestCase <ShowVacanciesPageSubmoduleViewOutput>
@property BOOL didLoadCalled;
@property ShowVacanciesPageSubmoduleView *showVacanciesPageSubmoduleView;
@property ShowVacanciesPageSubmoduleViewTableMaster *showVacanciesPageSubmoduleViewTableMaster;
@end

@implementation testShowVacanciesPageSubmoduleView

#pragma mark - Setup

- (void)setUp
{
    [super setUp];
    UIStoryboard *s = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.showVacanciesPageSubmoduleView = [s instantiateViewControllerWithIdentifier:@"ShowVacanciesPageSubmoduleView"];
    self.showVacanciesPageSubmoduleView.output = self;
    [self.showVacanciesPageSubmoduleView view]; //calls viewDidLoad
    [self waitForDidLoad:2];
}

- (void)tearDown
{
    self.showVacanciesPageSubmoduleView = nil;
    self.didLoadCalled = NO;
    [super tearDown];
}

#pragma mark - ShowVacanciesModuleViewOutput methods

- (void)viewDidLoad
{
    self.didLoadCalled = YES;
}

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
    [self.showVacanciesPageSubmoduleView showSpinner];
    
    //then
    XCTAssert(self.showVacanciesPageSubmoduleView.spinner.animating);
}

- (void)testStopsAnimatingSpinner
{
    //given
    
    //when
    [self.showVacanciesPageSubmoduleView showSpinner];
    [self.showVacanciesPageSubmoduleView hideSpinner];
    
    //then
    XCTAssertFalse(self.showVacanciesPageSubmoduleView.spinner.animating);
}

- (void)testPassesDataToTableMaster
{
    //given
    id data = [[NSObject alloc] init];
    
    //when
    [self.showVacanciesPageSubmoduleView showData:data];
    
    //then
    XCTAssert(self.showVacanciesPageSubmoduleView.tableMaster.vacancies == data );
}

@end
