//
//  testShowVacancyDetailsModuleView.m
//  SuperJob
//
//  Created by Roman S on 24.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ShowVacancyDetailsModuleView.h"

@interface testShowVacancyDetailsModuleView : XCTestCase<ShowVacancyDetailsModuleViewOutput>
@property ShowVacancyDetailsModuleView *view;
@property BOOL isViewDidLoadCalled;
@end

@implementation testShowVacancyDetailsModuleView

#pragma mark - Setup

- (void)setUp
{
    [super setUp];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    self.view = [storyboard instantiateViewControllerWithIdentifier:@"ShowVacancyDetailsModuleView"];
    self.view.output = self;
    [self.view view]; //calls ViewDidLoad
    [self waitForDidLoad:1];
}

- (void)tearDown
{
    self.view = nil;
    self.isViewDidLoadCalled = NO;
    [super tearDown];
}

#pragma mark - ShowVacancyDetailsModuleViewOutput methods

- (void)viewDidLoad
{
    self.isViewDidLoadCalled = YES;
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
    } while ( !self.isViewDidLoadCalled );
    
    return self.isViewDidLoadCalled;
}

#pragma mark - Tests

- (void)testCallsViewDidLoadOnOutput
{
    XCTAssertTrue(self.isViewDidLoadCalled);
}

- (void)testSetLabelsTextWhenShowVacancyCalled
{
    //given
    VacancyModel *vm = [[VacancyModel alloc] init];
    vm.profession = @"Писатель";
    vm.date_published = @"Сегодня";
    vm.payment = @"По договоренности";
    vm.townName = @"Ижевск";
    vm.experienceName = @"Без опыта";
    vm.educationName = @"Среднее образование";
    vm.compensation = @"Полная занятость";
    
    //when
    [self.view showVacancyDetails:vm];
    
    //then
    XCTAssertEqualObjects(vm.profession, self.view.professionLabel.text);
    
}

@end
