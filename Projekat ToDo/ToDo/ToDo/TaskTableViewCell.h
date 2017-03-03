//
//  TaskTableViewCell.h
//  ToDo
//
//  Created by Biljana on 3/3/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIView *groupView;
@property (strong, nonatomic) DBTask *task;
@end
