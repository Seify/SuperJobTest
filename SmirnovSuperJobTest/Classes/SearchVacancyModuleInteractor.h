//
//  SearchVacancyModuleInteractor.h
//  SuperJob
//
//  Created by Roman S on 14.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SearchVacancyModuleInteractorInput
- (void)loadVacanciesForKeyword:(NSString *)keyword;
@end

@protocol SearchVacancyModuleInteractorOutput
- (void)didLoadVacancies:(NSArray *)vacancies;
- (void)didFailLoadVacanciesWithErrorMessage:(NSString *)errorMessage;
@end


@interface SearchVacancyModuleInteractor : NSObject <SearchVacancyModuleInteractorInput>
@property (weak) id<SearchVacancyModuleInteractorOutput> output;
@end
