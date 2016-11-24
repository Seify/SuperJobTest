//
//  testShowVacanciesPageSubmoduleInteractor.m
//  SuperJob
//
//  Created by Roman S on 21.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ShowVacanciesPageSubmoduleInteractor.h"
#import "VacancyModel.h"
#import "SuperJobService.h"

@interface ShowVacanciesPageSubmoduleInteractor()<SuperJobServiceDelegate>
@property (weak) id<SuperJobServiceProtocol> service;
@end

@interface testShowVacanciesPageSubmoduleInteractor : XCTestCase<ShowVacanciesPageSubmoduleInteractorOutput, SuperJobServiceProtocol>
@property ShowVacanciesPageSubmoduleInteractor *interactor;
@property BOOL didLoadCalled;
@property BOOL didFailCalled;
@property NSString *errorMessage;
@property VacanciesPageModel *page;
@property BOOL loadPageCalled;
@end

@implementation testShowVacanciesPageSubmoduleInteractor

#pragma Setup

- (void)setUp
{
    [super setUp];
    self.interactor = [[ShowVacanciesPageSubmoduleInteractor alloc] init];
    self.interactor.service = self;
    self.interactor.output = self;
}

- (void)tearDown
{
    self.interactor = nil;
    self.didLoadCalled = NO;
    self.didFailCalled = NO;
    self.loadPageCalled = NO;
    self.errorMessage = nil;
    self.page = nil;
    [super tearDown];
}

#pragma mark - ShowVacanciesPageSubmoduleInteractorOutput methods

- (void)didLoadPage:(VacanciesPageModel *)page
{
    self.page = page;
    self.didLoadCalled = YES;
};

- (void)didFailLoadPageWithErrorMessage:(NSString *)errorMessage
{
    self.didFailCalled = YES;
    self.errorMessage = errorMessage;
};

#pragma mark - SuperJobServiceProtocol methods

- (void)loadPageForKeyword:(NSString *)keyword PageID:(int)pageID Delegate:(id<SuperJobServiceDelegate>)delegate
{
    self.loadPageCalled = YES;
};

- (void)cancelAllTasks
{
    
};


#pragma mark - Tests

- (void)testFailsOnNilKeyword
{
    //given
    
    //when
    [self.interactor requestPageForKeyword:nil PageID:0];
    
    //then
    XCTAssertTrue(self.didFailCalled);
}

- (void)testFailsOnEmptyKeyword
{
    //given
    
    //when
    [self.interactor requestPageForKeyword:@"" PageID:0];
    
    //then
    XCTAssertTrue(self.didFailCalled);
}

- (void)testFailsOnNegativePage
{
    //given
    
    //when
    [self.interactor requestPageForKeyword:@"слесарь" PageID:-1];
    
    //then
    XCTAssertTrue(self.didFailCalled);
}

- (void)testSendsRequestToServiceIfBothPageAndKeywordAreGood
{
    //given
    
    //when
    [self.interactor requestPageForKeyword:@"слесарь" PageID:0];
    
    //then
    XCTAssertTrue(self.loadPageCalled);
}

- (void)testCallsDidLoadWhenPageLoadedAndPassesPage
{
    //given
    VacanciesPageModel *page = [[VacanciesPageModel alloc] init];
    
    //when
    [self.interactor didLoadPage:page];
    
    //then
    XCTAssertTrue(self.didLoadCalled);
    XCTAssertEqualObjects(self.page, page);
}

- (void)testNotifiesOnFailWithError
{
    //given
    NSString *errorMessage = @"errorMessage";
    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : errorMessage };
    NSError *error = [NSError errorWithDomain:@"test error domain"
                                         code:111
                                     userInfo:userInfo];
    
    //when
    [self.interactor didFailLoadPageWithError:error];
    
    //then
    XCTAssertTrue(self.didFailCalled);
    XCTAssertEqualObjects(self.errorMessage, errorMessage);
}
@end
