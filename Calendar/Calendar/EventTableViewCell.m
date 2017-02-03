//
//  EventTableViewCell.m
//  Calendar
//
//  Created by Djuro Alfirevic on 2/1/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "EventTableViewCell.h"

@interface EventTableViewCell()
@property (weak,nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation EventTableViewCell

#pragma mark - Properties

- (void)setEvent:(NSString *)event {
    _event = event;
    
    self.titleLabel.text = event;
}

@end
