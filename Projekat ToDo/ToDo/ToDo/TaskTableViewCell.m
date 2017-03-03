//
//  TaskTableViewCell.m
//  ToDo
//
//  Created by Biljana on 3/3/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "TaskTableViewCell.h"

@implementation TaskTableViewCell

#pragma mark - Properties

- (void)setTask:(DBTask *)task {
    _task = task;
    
    self.titleLabel.text = task.title;
    self.descriptionLabel.text = task.desc;
}

@end
