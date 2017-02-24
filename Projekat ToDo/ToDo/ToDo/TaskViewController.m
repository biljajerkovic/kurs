//
//  TaskViewController.m
//  ToDo
//
//  Created by Biljana on 2/22/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "TaskViewController.h"
#import <MapKit/MapKit.h>

@interface TaskViewController() <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectorImageView;
@property (weak, nonatomic) IBOutlet UIImageView *mapImageView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
//@property (weak, nonatomic) IBOutlet UIView *greenView;
//@property (weak, nonatomic) IBOutlet UIView *orangeView;
//@property (weak, nonatomic) IBOutlet UIButton *purpleView;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *viewsArray;
@end

@implementation TaskViewController

# pragma mark - Actions

-(IBAction)backButtonTapped:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addButtonTapped:(UIButton *)sender {
}

- (IBAction)groupButtonTapped:(UIButton *)sender {
//    CGPoint center = CGPointZero;
    
//    switch (sender.tag) {
//        case TaskGroupComplited:
//            center = self.greenView.center;
//            break;
//            
//        case TaskGroupNotComplited:
//            center = self.orangeView.center;
//            break;
//            
//        case TaskGroupInProgress:
//            center = self.purpleView.center;
//            break;
//    }
    
    for (UIView *view in self.viewsArray) {
        if (view.tag == sender.tag) {
            [UIView animateWithDuration:kAnimationDuration animations:^{
                self.selectorImageView.center = view.center;
            }];
        }
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

@end
