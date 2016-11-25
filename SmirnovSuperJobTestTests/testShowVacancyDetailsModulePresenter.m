//
//  testShowVacancyDetailsModulePresenter.m
//  SuperJob
//
//  Created by Roman S on 24.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ShowVacancyDetailsModulePresenter.h"
#import "ShowVacancyDetailsModuleView.h"

@interface testShowVacancyDetailsModulePresenter : XCTestCase<ShowVacancyDetailsModuleViewInput>
@property ShowVacancyDetailsModulePresenter *presenter;
@property BOOL isShowVacancyCalledOnView;
@property VacancyModel *vacancyPassedByPresenter;
;
@end

@implementation testShowVacancyDetailsModulePresenter

#pragma mark - Setup

- (void)setUp
{
    self.presenter = [[ShowVacancyDetailsModulePresenter alloc] init];
    self.presenter.view = self;
    self.presenter.vacancy = [[VacancyModel alloc] init];
    [super setUp];
}

- (void)tearDown
{
    self.presenter = nil;
    self.vacancyPassedByPresenter = nil;
    self.isShowVacancyCalledOnView = NO;
    [super tearDown];
}

#pragma mark - ShowVacancyDetailsModuleViewInput methods

- (void)showVacancyDetails:(VacancyModel *)vacancy
{
    self.vacancyPassedByPresenter = vacancy;
    self.isShowVacancyCalledOnView = YES;
};

#pragma mark - Tests

- (void)testCallsShowVacancyOnViewWhenViewLoaded
{
    //given
    
    //when
    [self.presenter viewDidLoad];
    
    //then
    XCTAssertTrue(self.isShowVacancyCalledOnView);
    XCTAssertEqualObjects(self.vacancyPassedByPresenter, self.presenter.vacancy);
}


@end
