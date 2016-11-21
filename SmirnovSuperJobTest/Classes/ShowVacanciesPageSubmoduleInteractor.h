//
//  ShowVacanciesPageSubmoduleInteractor.h
//  SuperJob
//
//  Created by Roman S on 19.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ShowVacanciesPageSubmoduleInteractorInput
- (void)requestVacanciesForKeyword:(NSString *)keyword Page:(int)page;
@end

@protocol ShowVacanciesPageSubmoduleInteractorOutput
- (void)didLoadVacancies:(NSArray *)vacancies;
- (void)didFailLoadVacanciesWithErrorMessage:(NSString *)errorMessage;
@end


@interface ShowVacanciesPageSubmoduleInteractor : NSObject<ShowVacanciesPageSubmoduleInteractorInput>
@property (weak) id<ShowVacanciesPageSubmoduleInteractorOutput> output;
@end
