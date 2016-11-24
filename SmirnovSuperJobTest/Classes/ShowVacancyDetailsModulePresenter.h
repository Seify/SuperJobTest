//
//  ShowVacancyDetailsPresenter.h
//  SuperJob
//
//  Created by Roman S on 24.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShowVacancyDetailsModuleView.h"
#import "ShowVacancyDetailsModuleInteractor.h"
#import "ShowVacancyDetailsModuleRouter.h"

@protocol ShowVacancyDetailsModulePresenterInput<ShowVacancyDetailsModuleViewOutput, ShowVacancyDetailsModuleInteractorOutput, ShowVacancyDetailsModuleRouterOutput>
@end

@interface ShowVacancyDetailsModulePresenter : NSObject<ShowVacancyDetailsModulePresenterInput>
@property (weak) id<ShowVacancyDetailsModuleViewInput> view;
@property id<ShowVacancyDetailsModuleInteractorInput> interactor;
@property id<ShowVacancyDetailsModuleRouterInput> router;
@property VacancyModel *vacancy;
@end
