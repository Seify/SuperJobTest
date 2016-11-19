//
//  ShowVacanciesModulePresenter.h
//  SuperJob
//
//  Created by Roman S on 16.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShowVacanciesModuleInteractor.h"
#import "ShowVacanciesModuleView.h"
#import "ShowVacanciesModuleRouter.h"

@protocol ShowVacanciesModulePresenterInput <ShowVacanciesModuleViewOutput, ShowVacanciesModuleInteractorOutput, ShowVacanciesModuleRouterOutput>
@end

@interface ShowVacanciesModulePresenter : NSObject<ShowVacanciesModulePresenterInput>
@property (weak) id<ShowVacanciesModuleViewInput> view;
@property id<ShowVacanciesModuleRouterInput> router;
@property id<ShowVacanciesModuleInteractorInput> interactor;
@end
