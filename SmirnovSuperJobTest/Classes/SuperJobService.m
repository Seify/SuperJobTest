//
//  SuperJobService.m
//  SuperJob
//
//  Created by Roman S on 12.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import "SuperJobService.h"
#import "VacancyBuilder.h"

@implementation SuperJobService

+ (instancetype)sharedService
{
    static SuperJobService *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[SuperJobService alloc] init];
    });
    
    return _sharedInstance;
};

//TODO: remove this method
- (void)loadVacanciesForKeyword:(NSString *)keyword
{
    if ( keyword.length == 0 )
    {
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey: NSLocalizedString(@"Empty keyword.", nil) };
        NSError *emptyStringError = [NSError errorWithDomain:@"test error domain"
                                             code:999
                                         userInfo:userInfo];
        [self.delegate didFailLoadVacanciesWithError:emptyStringError];
        return;
    }
    
    ConnectionService *connectionService = [ConnectionService sharedService];
    connectionService.delegate = self;
    NSString *escapedKeyword = [keyword stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];    
    NSString *urlAsString = [NSString stringWithFormat:@"https://api.superjob.ru/2.0/vacancies/?keyword=%@", escapedKeyword];
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    connectionService.delegate = self;
    [connectionService loadDataFromURL:url];
};

- (void)loadVacanciesForKeyword:(NSString *)keyword Page:(int)page
{
    if ( keyword.length == 0 )
    {
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey: NSLocalizedString(@"Empty keyword.", nil) };
        NSError *emptyStringError = [NSError errorWithDomain:@"test error domain"
                                                        code:999
                                                    userInfo:userInfo];
        [self.delegate didFailLoadVacanciesWithError:emptyStringError];
        return;
    }
    
    ConnectionService *connectionService = [ConnectionService sharedService];
    connectionService.delegate = self;
    NSString *escapedKeyword = [keyword stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *urlAsString = [NSString stringWithFormat:@"https://api.superjob.ru/2.0/vacancies/?keyword=%@&page=%d", escapedKeyword, page];
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    connectionService.delegate = self;
    [connectionService loadDataFromURL:url];
};

- (void)connectionServiceDidLoadData:(NSData *)data
{
    NSError *error = nil;
    id JSONdata = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    NSArray *vacancies = [VacancyBuilder vacancyModelsFromJSON:JSONdata];
    [self.delegate didLoadVacancies:vacancies];
}

- (void)connectionDidFailWithError:(NSError *)error
{
    [self.delegate didFailLoadVacanciesWithError:error];
}

@end
