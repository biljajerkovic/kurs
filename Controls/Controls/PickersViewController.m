//
//  PickersViewController.m
//  Controls
//
//  Created by Djuro Alfirevic on 12/28/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "PickersViewController.h"

#define kNorthCity 0

@interface PickersViewController() <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (strong, nonatomic) NSArray *southCitiesArray;
@property (strong, nonatomic) NSArray *northCitiesArray;
@end

@implementation PickersViewController

#pragma mark - Actions

- (IBAction)datePickerValueChanged:(UIDatePicker *)sender {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"dd.MM.yyyy HH:mm:ss";
    
    self.dateTextField.text = [formatter stringFromDate:sender.date];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.southCitiesArray = @[@"Vranje", @"Leskovac", @"Niš", @"Pirot"];
    self.northCitiesArray = @[@"Subotica", @"Apatin", @"Novi Sad"];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == kNorthCity) {
        return self.northCitiesArray.count;
    }
    
    return self.southCitiesArray.count;
}

#pragma mark - UIPickerViewDelegate

// pickerView:titleForRow:forComponent
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *city = self.southCitiesArray[row];
    
    if (component == kNorthCity) {
        city = self.northCitiesArray[row];
    }
    
    return city;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString *city = self.southCitiesArray[row];
    
    if (component == kNorthCity) {
        city = self.northCitiesArray[row];
    }
    
    self.cityTextField.text = city;
}

@end
