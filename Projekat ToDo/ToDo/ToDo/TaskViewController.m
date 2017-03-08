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
@property (nonatomic) NSInteger group;
@end

@implementation TaskViewController

# pragma mark - Actions

-(IBAction)backButtonTapped:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addButtonTapped:(UIButton *)sender {
    if ([self validationPassed]) {
        [[DataManager sharedManager] saveTaskWithTitle:self.titleTextField.text description:self.descriptionTextField.text group:self.group];
        
        [self backButtonTapped:nil];
    }
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
    
    self.group = sender.tag;
    
    for (UIView *view in self.viewsArray) {
        if (view.tag == sender.tag) {
            [UIView animateWithDuration:kAnimationDuration animations:^{
                self.selectorImageView.center = view.center;
            }];
        }
    }
}

#pragma mark - Private API

- (BOOL)validationPassed {
    if (self.titleTextField.text == 0) {
        [self showAlertWithTitle:@"Error" andMessage:@"Please enter task title"];
        return NO; //ako nema title prikazi alert i vrati da nije izvrsena metoda
    }
    
    if (self.descriptionTextField.text == 0) {
        [self showAlertWithTitle:@"Error" andMessage:@"Please enter description"];
        return NO; //ako nema description prikazi alert i vrati da nije izvrsena metoda
    }
    
    return YES; //ako ima i title i description prodji
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.group = TaskGroupNotComplited; //setujemo defoltnu grupu
    
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
