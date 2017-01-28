//
//  SignUpViewController.m
//  ToDo
//
//  Created by Biljana on 12/30/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "SignUpViewController.h"

#define kToolbarHeight 44.0f

@interface SignUpViewController()
@property (weak, nonatomic) IBOutlet UIImageView *emailImageView;
@property (weak, nonatomic) IBOutlet UIImageView *birthdayImageView;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *birthdayTextField;
@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) UIToolbar *toolbar;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation SignUpViewController

#pragma mark - Properties

-(UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc]init];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.backgroundColor = [UIColor darkGrayColor];
        _datePicker.tintColor = [UIColor whiteColor];
    }
    return _datePicker;
}

-(UIToolbar *)toolbar {
    if (!_toolbar) {
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonTapped)];
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        CGRect frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, kToolbarHeight);
        _toolbar = [[UIToolbar alloc]initWithFrame:frame];
        _toolbar.items = @[flexibleSpace, doneButton];
    }
    return _toolbar;
}

-(NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc]init];
        _dateFormatter.dateFormat = @"dd.MM.yyyy";
    }
    return _dateFormatter;
}

# pragma mark - Actions

-(IBAction)backButtonTapped:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)doneButtonTapped {
    self.birthdayTextField.text = [self.dateFormatter stringFromDate:self.datePicker.date];
    [self.birthdayTextField resignFirstResponder];
}

#pragma mark - Private API

-(void)configurePlaceholders {
    [super configurePlaceholders];
    
    [self configureTextField:self.emailTextField];
    [self configureTextField:self.birthdayTextField];
}

-(void)configureDatePickerView {
    self.birthdayTextField.inputView = self.datePicker;
    self.birthdayTextField.inputAccessoryView = self.toolbar;
}

#pragma mark - UIResponder

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [super textFieldDidBeginEditing:textField];
    
    if (textField == self.emailTextField) {
        self.emailImageView.image = [UIImage imageNamed:@"email-active"];
    } else if (textField == self.birthdayTextField) {
        self.birthdayImageView.image = [UIImage imageNamed:@"birthday-active"];
        [self configureDatePickerView];
    }
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [super textFieldDidEndEditing:textField];
    
    self.emailImageView.image = [UIImage imageNamed:@"email"];
    self.birthdayImageView.image = [UIImage imageNamed:@"birthday"];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.usernameTextField) {
        [self.emailTextField becomeFirstResponder];
        return NO;
    } else if (textField == self.emailTextField) {
        [self.passwordTextField becomeFirstResponder];
        return NO;
    } else if (textField == self.passwordTextField) {
        [self.birthdayTextField becomeFirstResponder];
        return NO;
    }
    return YES;
}
@end
