//
//  SearchVacancyModuleInteractor.m
//  SuperJob
//
//  Created by Roman S on 14.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import "SearchVacancyModuleInteractor.h"

@interface SearchVacancyModuleInteractor()
@end

@implementation SearchVacancyModuleInteractor

- (BOOL)isGoodKeyword:(NSString *)keyword
{
    return ( keyword.length > 0 );
}

@end
