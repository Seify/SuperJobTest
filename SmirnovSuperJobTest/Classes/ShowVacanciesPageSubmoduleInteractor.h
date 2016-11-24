//
//  ShowVacanciesPageSubmoduleInteractor.h
//  SuperJob
//
//  Created by Roman S on 19.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VacancyModel.h"

@protocol ShowVacanciesPageSubmoduleInteractorInput
- (void)requestPageForKeyword:(NSString *)keyword PageID:(int)pageID;
@end

@protocol ShowVacanciesPageSubmoduleInteractorOutput
- (void)didLoadPage:(VacanciesPageModel *)page;
- (void)didFailLoadPageWithErrorMessage:(NSString *)errorMessage;
@end


@interface ShowVacanciesPageSubmoduleInteractor : NSObject<ShowVacanciesPageSubmoduleInteractorInput>
@property (weak) id<ShowVacanciesPageSubmoduleInteractorOutput> output;
@end
