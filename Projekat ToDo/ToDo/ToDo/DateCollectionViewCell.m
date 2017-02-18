//
//  DateCollectionViewCell.m
//  ToDo
//
//  Created by Biljana on 2/17/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "DateCollectionViewCell.h"
#import "Helpers.h"

@interface DateCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *weekdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UIView *highlightView;
@property (weak, nonatomic) IBOutlet UIView *hasTasksView;
@end

@implementation DateCollectionViewCell

#pragma  mark - Properties

-(void)setDate:(NSDate *)date {
    _date = date;
    
    self.dayLabel.text = [Helpers valueFrom:date withFormat:@"d"];
    self.weekdayLabel.text = [self weekday];
    
    NSDate *todayDate = [NSDate date];
    if ([todayDate isEqual:date]) {
        self.highlightView.hidden = NO;
    } else {
        self.highlightView.hidden = YES;
    }
    
    self.highlightView.hidden = ([Helpers isDate:date sameAsDate:[NSDate date]]) ? NO : YES; //ternarni operator
}

#pragma mark - Private API

-(NSString *)weekday {
    NSString *string = [Helpers valueFrom:self.date withFormat:@"EEEE"];
    string = string.uppercaseString;
    string = [string substringToIndex:3];
    
    return string;
}

@end
