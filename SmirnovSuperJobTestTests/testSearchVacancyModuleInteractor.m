//
//  testSearchVacancyModuleInteractor.m
//  SuperJob
//
//  Created by Roman S on 15.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SearchVacancyModuleInteractor.h"
#import "VacancyModel.h"

@interface testSearchVacancyModuleInteractor : XCTestCase <SearchVacancyModuleInteractorOutput>
@property SearchVacancyModuleInteractor *interactor;
@property BOOL didLoadCalled;
@property NSArray *vacancies;
@property BOOL didFailCalled;
@property NSString *errorMessage;
@end

@implementation testSearchVacancyModuleInteractor

#pragma mark - Setup

- (void)setUp
{
    [super setUp];
    self.interactor = [[SearchVacancyModuleInteractor alloc] init];
    self.interactor.output = self;
}

- (void)tearDown
{
    self.didLoadCalled = NO;
    self.vacancies = nil;
    self.didFailCalled = NO;
    self.errorMessage = nil;
    [super tearDown];
}

#pragma mark - SearchVacancyModuleInteractorOutput methods

- (void)didLoadVacancies:(NSArray *)vacancies
{
    self.didLoadCalled = YES;
    self.vacancies = vacancies;
};

- (void)didFailLoadVacanciesWithErrorMessage:(NSString *)errorMessage
{
    self.didFailCalled = YES;
    self.errorMessage = errorMessage;
};

#pragma mark - Helpers

- (BOOL)waitForLoad:(NSTimeInterval)timeoutSecs
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

- (void)testFailsOnNilKeyword
{
    //given
    NSString *keyword = nil;
    
    //when
    [self.interactor loadVacanciesForKeyword:keyword];
    
    //then
    XCTAssertTrue(self.didFailCalled);
    XCTAssert([self.errorMessage isEqualToString:@"Empty keyword."]);
}

- (void)testFailsOnEmptyKeyword
{
    //given
    NSString *keyword = @"";
    
    //when
    [self.interactor loadVacanciesForKeyword:keyword];
    
    //then
    XCTAssertTrue(self.didFailCalled);
    XCTAssert([self.errorMessage isEqualToString:@"Empty keyword."]);
}

//TODO: make mocks for interactor's services
- (void)testReturnsEmptyArrayForNonexistingKeyword
{
    //given
    NSString *keyword = @"dfgsdfgsdfhdsfhdfshfdghdffg";
    
    //when
    [self.interactor loadVacanciesForKeyword:keyword];
    
    //then
    XCTAssertTrue([self waitForLoad:10]);
    XCTAssert([self.vacancies isKindOfClass:[NSArray class]]);
    XCTAssert(self.vacancies.count == 0);
}

- (void)testReturnsArrayOfVacanciesOnGoodKeyword
{
    //given
    NSString *keyword = @"грузчик, кладовщик";
    
    //when
    [self.interactor loadVacanciesForKeyword:keyword];
    
    //then
    XCTAssertTrue([self waitForLoad:10]);
    XCTAssert([self.vacancies isKindOfClass:[NSArray class]]);
    for ( id vacancy in self.vacancies )
    {
        [vacancy isKindOfClass:[VacancyModel class]];
    }
    XCTAssert(self.vacancies.count > 0);
}


@end
