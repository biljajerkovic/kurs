//
//  DateCollectionViewCell.m
//  ToDo
//
//  Created by Biljana on 2/17/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "DateCollectionViewCell.h"
#import "Helpers.m"

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
    self.weekdayLabel.text = [Helpers valueFrom:date withFormat:@"EEE"];
    
    NSDate *todayDate = [NSDate date];
    if ([todayDate isEqual:date]) {
        self.highlightView.hidden = NO;
    } else {
        self.highlightView.hidden = YES;
    }
    
    //Ternary operator umesto iznad if else - AKO ISPUNJAVA USLOV UZIMA SA LEVE STRANE ":", AKO NE DESNO.
    //self.highlightView.hidden = ([todayDate isEqualToDate:date]) ? NO : YES;
}
@end
