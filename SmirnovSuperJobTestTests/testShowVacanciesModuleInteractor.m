//
//  testShowVacanciesModuleInteractor.m
//  SuperJob
//
//  Created by Roman S on 23.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ShowVacanciesModuleInteractor.h"
#import "SuperJobService.h"

@interface ShowVacanciesModuleInteractor()
@property id<SuperJobServiceProtocol> service;
@end


@interface testShowVacanciesModuleInteractor : XCTestCase<SuperJobServiceProtocol>
@property ShowVacanciesModuleInteractor *interactor;
@property BOOL cancelAllTasksCalled;
@end

@implementation testShowVacanciesModuleInteractor

#pragma mark - Setup

- (void)setUp
{
    [super setUp];
    self.interactor = [[ShowVacanciesModuleInteractor alloc] init];
    self.interactor.service = self;
}

- (void)tearDown
{
    self.interactor = nil;
    self.cancelAllTasksCalled = NO;
    [super tearDown];
}

#pragma mark - SuperJobServiceProtocol methods

- (void)loadPageForKeyword:(NSString *)keyword PageID:(int)pageID Delegate:(id<SuperJobServiceDelegate>)delegate
{
    
};

- (void)cancelAllTasks
{
    self.cancelAllTasksCalled = YES;
};

#pragma mark - Tests

- (void)testCallsCancelAllTasksOfService
{
    //given
    
    //when
    [self.interactor stopAllTasks];
    
    //then
    XCTAssertTrue(self.cancelAllTasksCalled);
}

@end
