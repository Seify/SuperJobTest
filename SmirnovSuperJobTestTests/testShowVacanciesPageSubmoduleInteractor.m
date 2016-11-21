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

@interface ShowVacanciesPageSubmoduleInteractor()
- (void)didFailLoadVacanciesWithError:(NSError *)error;
@end

@interface testShowVacanciesPageSubmoduleInteractor : XCTestCase<ShowVacanciesPageSubmoduleInteractorOutput>
@property ShowVacanciesPageSubmoduleInteractor *interactor;
@property BOOL didLoadCalled;
@property NSArray *vacancies;
@property BOOL didFailCalled;
@property NSString *errorMessage;
@end

@implementation testShowVacanciesPageSubmoduleInteractor

#pragma Setup

- (void)setUp
{
    [super setUp];
    self.interactor = [[ShowVacanciesPageSubmoduleInteractor alloc] init];
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

#pragma mark - ShowVacanciesPageSubmoduleInteractorOutput methods

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
    int page = 0;
    
    //when
    [self.interactor requestVacanciesForKeyword:keyword Page:page];
    
    //then
    XCTAssertTrue(self.didFailCalled);
    XCTAssert([self.errorMessage isEqualToString:@"Empty keyword."]);
}

- (void)testFailsOnEmptyKeyword
{
    //given
    NSString *keyword = @"";
    int page = 0;
    
    //when
    [self.interactor requestVacanciesForKeyword:keyword Page:page];
    
    //then
    XCTAssertTrue(self.didFailCalled);
    XCTAssert([self.errorMessage isEqualToString:@"Empty keyword."]);
}

- (void)testReturnsEmptyArrayForNonexistingKeyword
{
    //given
    NSString *keyword = @"dfgsdfgsdfhdsfhdfshfdghdffg";
    int page = 0;
    
    //when
    [self.interactor requestVacanciesForKeyword:keyword Page:page];
    
    //then
    XCTAssertTrue([self waitForLoad:10]);
    XCTAssert([self.vacancies isKindOfClass:[NSArray class]]);
    XCTAssert(self.vacancies.count == 0);
}

- (void)testFailsOnNegativePage
{
    //given
    NSString *keyword = @"грузчик";
    int page = -1;
    
    //when
    [self.interactor requestVacanciesForKeyword:keyword Page:page];
    
    //then
    XCTAssertTrue(self.didFailCalled);
    XCTAssert([self.errorMessage isEqualToString:@"Wrong page."]);
}

- (void)testReturnsArrayOfVacanciesOnGoodKeywordAndPage
{
    //given
    NSString *keyword = @"грузчик, кладовщик";
    int page = 0;
    
    //when
    [self.interactor requestVacanciesForKeyword:keyword Page:page];
     
     //then
     XCTAssertTrue([self waitForLoad:10]);
     XCTAssert([self.vacancies isKindOfClass:[NSArray class]]);
     for ( id vacancy in self.vacancies )
     {
         [vacancy isKindOfClass:[VacancyModel class]];
     }
     XCTAssert(self.vacancies.count > 0);
}

- (void)testNotifiesDelegateOnFailWithErrorMessage
{
    //given
    NSString *errorMessage = @"errorMessage";
    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey: NSLocalizedString(errorMessage, nil) };
    NSError *error = [NSError errorWithDomain:@"test error domain"
                                         code:111
                                     userInfo:userInfo];
    
    //when
    [self.interactor didFailLoadVacanciesWithError:error];
    
    //then
    XCTAssertTrue(self.didFailCalled);
    XCTAssertEqualObjects(self.errorMessage, errorMessage);
}

@end
