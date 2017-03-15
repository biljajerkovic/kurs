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

#pragma mark - Properties

- (void)setGroup:(NSInteger)group {
    _group = group;
    
    // Move selector to appropriate group.
    for (UIView *view in self.viewsArray) {
        if (view.tag == group) {
            [UIView animateWithDuration:kAnimationDuration animations:^{
                self.selectorImageView.center = view.center;
            }];
        }
    }
}

# pragma mark - Actions

-(IBAction)backButtonTapped:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addButtonTapped:(UIButton *)sender {
    if ([self validationPassed]) {
        if (self.task) {
            self.task.heading = self.titleTextField.text;
            self.task.desc = self.descriptionTextField.text;
            self.task.group = self.group;
            self.task.latitude = DATA_MANAGER.userLocation.coordinate.latitude;
            self.task.longitude = DATA_MANAGER.userLocation.coordinate.longitude;

            [DATA_MANAGER updateObject:self.task];
        } else {
            [DATA_MANAGER saveTaskWithTitle:self.titleTextField.text
                                               description:self.descriptionTextField.text
                                                     group:self.group];
        }
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

- (void)configureUI {
    self.locationLabel.text = DATA_MANAGER.userLocality;
    
    if (self.task) {
        self.titleTextField.text = self.task.heading;
        self.descriptionTextField.text = self.task.desc;
        self.group = self.task.group;
        [self.mapView addAnnotation:self.task];
        [self zoomToCoordinate:self.task.coordinate];
        
    } else {
        self.group = TaskGroupNotComplited; //setujemo defoltnu grupu
        
        self.mapView.showsUserLocation = YES; //pokazuje ciodu
        [self zoomToCoordinate:DATA_MANAGER.userLocation.coordinate];
    }
}

- (void)zoomToCoordinate:(CLLocationCoordinate2D)coordinate {
    // Zoom map
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(kSpanDelta,kSpanDelta));
    [self.mapView setRegion:region animated:YES];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureUI];
    
    // VIA DELEGATE
    // DataManager *dataManager = DATA_MANAGER;
    DATA_MANAGER.delegate = self;
    
    // VIA NOTIFICATION
    [[NSNotificationCenter defaultCenter] addObserverForName:LOCALITY_UPDATED_NOTIFICATION object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        self.locationLabel.text = DATA_MANAGER.userLocality;
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
    self.locationLabel.text = DATA_MANAGER.userLocality;
}

@end
