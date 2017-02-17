//
//  Helpers.m
//  ToDo
//
//  Created by Biljana on 2/15/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "Helpers.h"

@implementation Helpers

#pragma mark - Public Api

+ (BOOL)isMorning {
    NSInteger hours = [[NSCalendar currentCalendar] component:NSCalendarUnitHour fromDate:[NSDate date]];
    if (hours < 12) {
        return YES;
    }
    return NO;
}

+ (NSString *)valueFrom:(NSDate *)date withFormat:(NSString *)format {
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
    dateFormater.dateFormat = format;
    return [dateFormater stringFromDate:date];
}
@end
