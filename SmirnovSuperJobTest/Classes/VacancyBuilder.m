//
//  SuperJobVacancyBuilder.m
//  SuperJob
//
//  Created by Roman S on 12.11.16.
//  Copyright © 2016 RomanS. All rights reserved.
//

#import "VacancyBuilder.h"

@interface VacancyBuilder()
+ (NSString *)dayAndMonthStringFromDate:(NSDate *)date_published WithLocale:(NSLocale *)locale;
+ (BOOL)isDateToday:(NSDate *)date;
+ (NSString *)dateFromUnixtime:(int)unixtime;
+ (NSString *)paymentNameFromPaymentFrom:(NSNumber *)paymentFrom PaymentTo:(NSNumber *)paymentTo;
+ (NSString *)paymentNameFromDictionary:(NSDictionary *)objectDict;
+ (VacancyModel *)vacancyFromDictionary:(NSDictionary *)objectDict;
+ (NSError *)errorFromJSON:(id<NSObject>)JSONData;
+ (NSArray *)vacanciesFromJSON:(NSDictionary *)JSONDict;
+ (VacanciesPageModel *)pageFromJSON:(NSDictionary *)JSONDict PageID:(int)pageID Keyword:(NSString *)keyword;
@end

@implementation VacancyBuilder

+ (NSString *)dayAndMonthStringFromDate:(NSDate *)date_published WithLocale:(NSLocale *)locale
{
    NSString *format = [NSDateFormatter dateFormatFromTemplate:@"d MMM" options:0
                                                        locale:locale];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = locale;
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:date_published];
}

+ (BOOL)isDateToday:(NSDate *)date
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[NSDate date]];
    NSDate *today = [cal dateFromComponents:components];
    
    components = [cal components:(NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    NSDate *date_day = [cal dateFromComponents:components];
    
    return [today isEqualToDate:date_day];
}

+ (NSString *)dateFromUnixtime:(int)unixtime
{
    NSDate *date_published = [NSDate dateWithTimeIntervalSince1970:unixtime];
    if ( [self isDateToday:date_published] )
    {
        return @"Сегодня";
    }
    else
    {
        return [self dayAndMonthStringFromDate:date_published WithLocale:[NSLocale currentLocale]];
    }
}

+ (NSString *)paymentNameFromPaymentFrom:(NSNumber *)paymentFrom PaymentTo:(NSNumber *)paymentTo
{
    if ( [paymentFrom intValue] && [paymentTo intValue] )
    {
        return [NSString stringWithFormat:@"%dР - %dР", [paymentFrom intValue], [paymentTo intValue]];
    }
    else if ( [paymentFrom intValue] )
    {
        return [NSString stringWithFormat:@"от %dР", [paymentFrom intValue]];
    }
    else if ( [paymentTo intValue] )
    {
        return [NSString stringWithFormat:@"до %dР", [paymentTo intValue]];
    }
    else
    {
        return nil;
    }
}

+ (NSString *)paymentNameFromDictionary:(NSDictionary *)objectDict
{
    if ( [objectDict[@"agreement"] boolValue] )
    {
        return @"По договоренности";
    }
    else
    {
        return [self paymentNameFromPaymentFrom:objectDict[@"payment_from"] PaymentTo:objectDict[@"payment_to"]];
    }
}

+ (VacancyModel *)vacancyFromDictionary:(NSDictionary *)objectDict
{
    VacancyModel *vm = [[VacancyModel alloc] init];
    
    vm.profession               = objectDict[@"profession"];
    vm.date_published           = [self dateFromUnixtime:[objectDict[@"date_published"] intValue]];
    vm.work                     = objectDict[@"work"];
    vm.payment                  = [self paymentNameFromDictionary:objectDict];
    vm.address                  = objectDict[@"address"];
    vm.townName                 = [objectDict[@"town"] objectForKey:@"title"];
    vm.educationName            = [objectDict[@"education"] objectForKey:@"title"];
    vm.experienceName           = [objectDict[@"experience"] objectForKey:@"title"];
    vm.firmName                 = objectDict[@"firm_name"];
    vm.compensation             = objectDict[@"compensation"];

    return vm;
}

+ (NSError *)errorFromJSON:(NSDictionary *)JSONDict
{
    NSDictionary *errorDict = JSONDict[@"error"];
    if ( errorDict )
    {
        NSString *errorMessage = errorDict[@"message"];
        NSNumber *errorCode = errorDict[@"code"];
        NSNumber *errorReason = errorDict[@"error"];
        
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey: errorMessage, NSLocalizedFailureReasonErrorKey : errorReason };
        return [NSError errorWithDomain:@"SuperJob server error domain"
                                   code:[errorCode integerValue]
                               userInfo:userInfo];
    }
    else
    {
        return nil;
    }
}

+ (NSArray *)vacanciesFromJSON:(NSDictionary *)JSONDict
{
    NSArray *objects = JSONDict[@"objects"];
    NSMutableArray *vacancies = [NSMutableArray array];
    for ( NSDictionary *objectDict in objects )
    {
        VacancyModel *vm = [self vacancyFromDictionary:objectDict];
        [vacancies addObject:vm];
    }
    return vacancies;
}

+ (VacanciesPageModel *)pageFromJSON:(NSDictionary *)JSONDict PageID:(int)pageID Keyword:(NSString *)keyword
{
    VacanciesPageModel *pageModel = [[VacanciesPageModel alloc] init];
    pageModel.vacancies = [self vacanciesFromJSON:JSONDict];
    pageModel.hasMore = [JSONDict[@"more"] boolValue];
    pageModel.pageID = pageID;
    pageModel.keyword = keyword;
    return pageModel;
}

+ (VacanciesPageModel *)pageFromJSON:(NSDictionary *)JSONDict PageID:(int)pageID Keyword:(NSString *)keyword Error:(NSError **)error
{
    *error = [self errorFromJSON:JSONDict];
    if (*error)
    {
        return nil;
    }
    else
    {
        return [self pageFromJSON:JSONDict PageID:pageID Keyword:keyword];
    }
};

@end
