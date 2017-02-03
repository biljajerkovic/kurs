//
//  DateCollectionViewCell.m
//  Calendar
//
//  Created by Djuro Alfirevic on 2/1/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "DateCollectionViewCell.h"

@interface DateCollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation DateCollectionViewCell

#pragma mark - Properties

- (void)setItem:(id)item {
    _item = item;
    
    // If item is NSDate - then show actual date using NSDateFormatter, otherwise show an empty string 
    if ([item isKindOfClass:NSDate.class]) {
        NSDate *date = (NSDate *)item;
        
        // We extract day from date and show it in label
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"d";
        
        self.titleLabel.text = [dateFormatter stringFromDate:date];
    } else {
        self.titleLabel.text = @"";
    }
}

@end
