//
//  TaskViewController.m
//  ToDo
//
//  Created by Biljana on 2/22/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "TaskViewController.h"
#import <MapKit/MapKit.h>

@interface TaskViewController() <UITextFieldDelegate, DataManagerDelegate>
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

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationLabel.text = [DataManager sharedManager].userLocality;
    
    // VIA DELEGATE
    // DataManager *dataManager = [DataManager sharedManager];
    [DataManager sharedManager].delegate = self;
    
    // VIA NOTIFICATION
    [[NSNotificationCenter defaultCenter] addObserverForName:LOCALITY_UPDATED_NOTIFICATION object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        self.locationLabel.text = [DataManager sharedManager].userLocality;
    }];
}

// Uvek ovo stavljamo jer kad predjemo na drugi ekran nas ta info ne zanima
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - DataManagerDelegate

- (void)dataManagerDidUpdateLocality {
    self.locationLabel.text = [DataManager sharedManager].userLocality;
}

@end
