//
//  SearchVacancyModuleInteractor.h
//  SuperJob
//
//  Created by Roman S on 14.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SearchVacancyModuleInteractorInput
- (BOOL)isGoodKeyword:(NSString *)keyword;
@end

@protocol SearchVacancyModuleInteractorOutput
@end


@interface SearchVacancyModuleInteractor : NSObject <SearchVacancyModuleInteractorInput>
@property (weak) id<SearchVacancyModuleInteractorOutput> output;
@end
