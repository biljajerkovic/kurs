//
//  TaskViewController.m
//  ToDo
//
//  Created by Biljana on 2/22/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "TaskViewController.h"

@interface TaskViewController ()
@end

@implementation TaskViewController

# pragma mark - Actions

-(IBAction)backButtonTapped:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
