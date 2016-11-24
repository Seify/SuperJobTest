//
//  ShowVacancyDetailsInteractor.h
//  SuperJob
//
//  Created by Roman S on 24.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ShowVacancyDetailsModuleInteractorInput
@end

@protocol ShowVacancyDetailsModuleInteractorOutput
@end

@interface ShowVacancyDetailsModuleInteractor : NSObject<ShowVacancyDetailsModuleInteractorInput>
@property (weak) id<ShowVacancyDetailsModuleInteractorOutput> output;
@end
