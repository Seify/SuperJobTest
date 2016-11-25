//
//  ShowVacanciesPageSubmodulePresenter.h
//  SuperJob
//
//  Created by Roman S on 19.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShowVacanciesPageSubmoduleView.h"
#import "ShowVacanciesPageSubmoduleInteractor.h"
#import "ShowVacanciesPageSubmodulePresenter.h"
#import "ShowVacanciesPageSubmoduleRouter.h"

@protocol ShowVacanciesPageSubmodulePresenterInput<ShowVacanciesPageSubmoduleViewOutput, ShowVacanciesPageSubmoduleInteractorOutput, ShowVacanciesPageSubmoduleRouterOutput, ShowVacanciesPageSubmoduleViewTableMasterOutput>
@end

@protocol ShowVacanciesPageSubmodulePresenterOutput
@end

@interface ShowVacanciesPageSubmodulePresenter : NSObject<ShowVacanciesPageSubmodulePresenterInput>
@property (weak) id<ShowVacanciesPageSubmoduleViewInput> view;
@property id<ShowVacanciesPageSubmoduleInteractorInput> interactor;
@property id<ShowVacanciesPageSubmoduleRouterInput> router;
@property VacanciesPageModel *page;

- (void)startWithPageID:(int)pageID Keyword:(NSString *)keyword;
@end
