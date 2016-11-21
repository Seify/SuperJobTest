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
#import "SearchVacancyModuleRouter.h"

@protocol SearchVacancyModulePresenterInput <SearchVacancyModuleViewOutput, SearchVacancyModuleInteractorOutput>
@end

@interface SearchVacancyModulePresenter : NSObject <SearchVacancyModulePresenterInput>
@property (weak)id<SearchVacancyModuleViewInput> view;
@property id<SearchVacancyModuleInteractorInput> interactor;
@property id<SearchVacancyModuleRouterInput> router;
@end
