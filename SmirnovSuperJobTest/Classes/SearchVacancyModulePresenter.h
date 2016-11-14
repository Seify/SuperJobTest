//
//  SearchVacancyModulePresenter.h
//  SuperJob
//
//  Created by Roman S on 14.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchVacancyModuleView.h"
#import "SearchVacancyModuleInteractor.h"

@protocol SearchVacancyModuleInput <NSObject>
- (void)configureModule;
@end

@protocol SearchVacancyModulePresenterInput <SearchVacancyModuleViewOutput, SearchVacancyModuleInteractorOutput>
@end

@interface SearchVacancyModulePresenter : NSObject <SearchVacancyModulePresenterInput>
@property (weak)id<SearchVacancyModuleViewInput> view;
@property (weak)id<SearchVacancyModuleInteractorInput> interactor;
@end
