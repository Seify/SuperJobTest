//
//  SuperJobVacancyBuilder.m
//  SuperJob
//
//  Created by Roman S on 12.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import "VacancyBuilder.h"

@implementation VacancyBuilder

+ (NSArray *)vacancyModelsFromJSON:(id<NSObject>)JSONData
{
    // handle unexpected format
    if ( ![JSONData isKindOfClass:[NSDictionary class]] )
    {
        return nil;
    }

    NSDictionary *JSONDict = (NSDictionary *)JSONData;

    //handle server error
    if ( JSONData[@"error"] )
    {
        return nil;
    }
    
    //create model
    NSArray *objects = JSONDict[@"objects"];
    NSMutableArray *models = [NSMutableArray array];
    for ( NSDictionary *objectDict in objects )
    {
        VacancyModel *vm = [[VacancyModel alloc] init];
        
        vm.profession               = objectDict[@"profession"];
        int date_published_unixtime = [objectDict[@"profession"] intValue];
        vm.date_published           = [NSDate dateWithTimeIntervalSince1970:date_published_unixtime];
        vm.work                     = objectDict[@"work"];
        NSString *compensationName  = objectDict[@"compensation"];
        if ( !compensationName )
        {
            compensationName = [NSString stringWithFormat:@"%d - %d", [objectDict[@"payment_from"] intValue], [objectDict[@"payment_to"] intValue]];
        }
        vm.compensation             = compensationName;
        vm.address                  = objectDict[@"address"];
        vm.townName                 = [objectDict[@"town"] objectForKey:@"title"];
        vm.educationName            = [objectDict[@"education"] objectForKey:@"title"];
        vm.experienceName           = [objectDict[@"experience"] objectForKey:@"title"];
        [models addObject:vm];
    }
    return models;
};

@end
