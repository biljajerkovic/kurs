//
//  Helpers.h
//  ToDo
//
//  Created by Biljana on 2/15/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helpers : NSObject
+ (BOOL)isMorning;
+ (NSString *)valueFrom: (NSDate *)date withFormat:(NSString *)format;
+ (NSInteger)numberOfDaysInMonthForDate:(NSDate *)date;
+ (BOOL)isDate:(NSDate *)date sameAsDate:(NSDate *)otherDate;
+ (void)saveCustomObjectToUserDefaults:(id)object forKey:(NSString *)key; //snima custom klasu u UserDefaults
+ (id)loadCustomObjectFromUserDefaultsForKey:(NSString *)key; //ucitava
+ (BOOL)isLoggedIn;
@end
