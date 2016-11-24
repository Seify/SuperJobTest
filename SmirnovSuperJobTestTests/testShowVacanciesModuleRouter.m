//
//  testShowVacanciesModuleRouter.m
//  SuperJob
//
//  Created by Roman S on 23.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ShowVacanciesModuleRouter.h"
#import "VacancyModel.h"
#import "ShowVacanciesPageSubmoduleView.h"

@interface ShowVacanciesModuleRouter()
@property NSMutableArray *submodules;
@property Class submoduleAssemblerClass;
@end

static id passedParentRouter;
static int passedPageID;
static NSString *passedKeyword;
static BOOL assemblingCalled;
static ShowVacanciesPageSubmoduleView *assembledSubmodule;

@interface testShowVacanciesModuleRouter : XCTestCase<ShowVacanciesModuleRouterOutput>
@property ShowVacanciesModuleRouter *router;
@property ShowVacanciesPageSubmoduleView *firstPageSubmodule;
@property ShowVacanciesPageSubmoduleView *secondPageSubmodule;
@property BOOL willRouteToPrevModuleCalled;
@property BOOL popCalled;
@end

@implementation testShowVacanciesModuleRouter

#pragma mark - Setup

- (void)setUp
{
    [super setUp];
    
    self.firstPageSubmodule = [[ShowVacanciesPageSubmoduleView alloc] init];
    self.firstPageSubmodule.page = [[VacanciesPageModel alloc] init];
    self.firstPageSubmodule.page.pageID = 0;
    self.firstPageSubmodule.page.hasMore = YES;
    
    self.secondPageSubmodule = [[ShowVacanciesPageSubmoduleView alloc] init];
    self.secondPageSubmodule.page = [[VacanciesPageModel alloc] init];
    self.secondPageSubmodule.page.pageID = 1;
    self.secondPageSubmodule.page.hasMore = NO;
    
    self.router = [[ShowVacanciesModuleRouter alloc] init];
    self.router.submoduleAssemblerClass = [self class];
    self.router.submodules = [@[self.firstPageSubmodule, self.secondPageSubmodule] mutableCopy];
    self.router.output = self;
    self.router.rootController = (UINavigationController *)self;
}

- (void)tearDown
{
    self.router = nil;
    passedParentRouter = nil;
    passedPageID = 0;
    passedKeyword = nil;
    assembledSubmodule = nil;
    assemblingCalled = NO;
    self.willRouteToPrevModuleCalled = NO;
    self.popCalled = NO;
    [super tearDown];
}

#pragma mark - submoduleAssemblerClass methods

+ (UIViewController *)submoduleWithParentRouter:(id)parentRouter Page:(int)pageID Keyword:(NSString *)keyword
{
    passedParentRouter = parentRouter;
    passedPageID = pageID;
    passedKeyword = keyword;
    assemblingCalled = YES;
    assembledSubmodule = [[ShowVacanciesPageSubmoduleView alloc] init];
    return assembledSubmodule;
}

#pragma mark - ShowVacanciesModuleRouterOutput methods

- (void)willRouteToPrevModule
{
    self.willRouteToPrevModuleCalled = YES;
};

#pragma mark - UINavigationController methods

- (void)popViewControllerAnimated:(BOOL)animated
{
    self.popCalled = YES;
};

#pragma mark - Tests

- (void)testPassesGoodParametersToSubmoduleAssembler
{
    //given
    int pageID = 1;
    NSString *keyword = @"Смотритель зоопарка";
    
    //when
    [self.router pageSubmoduleWithPage:pageID Keyword:keyword];
    
    //then
    XCTAssertTrue(assemblingCalled);
    XCTAssert( pageID == passedPageID );
    XCTAssert( [keyword isEqualToString:passedKeyword] );
    XCTAssertEqualObjects(self.router, passedParentRouter );
}

- (void)testReturnsNilAsPrevSubmoduleForFirstPage
{
    //given
    
    //when
    
    //then
    XCTAssertNil([self.router pageSubmoduleViewBeforePageSubmoduleView:self.firstPageSubmodule]);
}

- (void)testReturnsFirstPageAsPrevSubmoduleForSecondPage
{
    //given
    
    //when
    
    //then
    XCTAssertEqualObjects(self.firstPageSubmodule, [self.router pageSubmoduleViewBeforePageSubmoduleView:self.secondPageSubmodule]);
}

- (void)testReturnsSecondPageAsNextSubmoduleForFirstPage
{
    //given
    
    //when
    
    //then
    XCTAssertEqualObjects(self.secondPageSubmodule, [self.router pageSubmoduleViewAfterPageSubmoduleView:self.firstPageSubmodule]);
}

- (void)testReturnsNilAsNextSubmoduleForPageWithNOHasMore
{
    //given
    self.secondPageSubmodule.page.hasMore = NO;
    
    //when
    
    //then
    XCTAssertNil([self.router pageSubmoduleViewAfterPageSubmoduleView:self.secondPageSubmodule]);
}

- (void)testAssemblesNewSubmoduleForLastPageWithHasMore
{
    //given
    self.secondPageSubmodule.page.hasMore = YES;
    
    //when
    id newSubmodule = [self.router pageSubmoduleViewAfterPageSubmoduleView:self.secondPageSubmodule];
    
    //then
    XCTAssertEqualObjects(assembledSubmodule, newSubmodule);
}

- (void)testNotifiesPresenterOnRoutingToPrevModule
{
    //given
    
    //when
    [self.router routeToPrevModule];
    
    //then
    XCTAssertTrue(self.willRouteToPrevModuleCalled);
}

- (void)testPopsToPrevController
{
    //given
    
    //when
    [self.router routeToPrevModule];
    
    //then
    XCTAssertTrue(self.popCalled);
}

#warning Test routeToNextModuleWithVacancy!

@end
