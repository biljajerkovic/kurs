//
//  LoginViewController.m
//  ToDo
//
//  Created by Administrator on 14/12/2016.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "LoginViewController.h"
#import "User.h"

@interface LoginViewController()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textFieldsContainerViewBottomConstraint;
@property (nonatomic) CGFloat bottomConstraint;
@property (weak, nonatomic) IBOutlet UIView *logoView;
@end

@implementation LoginViewController

#pragma mark - Public API

-(void)configurePlaceholders {
    self.attributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    [self configureTextField:self.usernameTextField];
    [self configureTextField:self.passwordTextField];
}

-(void)configureTextField:(UITextField *)textField {
    NSAttributedString *attributedString = [[NSAttributedString alloc]initWithString:textField.placeholder attributes:self.attributes];
    textField.attributedPlaceholder = attributedString;
}

#pragma mark - Actions

-(IBAction)confirmButtonTapped {
    [self loginUser];
}

-(void)loginUser {
    NSLog(@"Logging in with %@ and %@",
          self.usernameTextField.text,
          self.passwordTextField.text);
    
    // Save user to NSUserDefaults
    User *user = [[User alloc]init];
    user.username = self.usernameTextField.text;
    user.password = self.passwordTextField.text;
    [Helpers saveCustomObjectToUserDefaults:user forKey:USER_UD];
    
    [self performSegueWithIdentifier:@"HomeSegue" sender:nil];
}

#pragma mark - Private API

-(void)registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserverForName:
     UIKeyboardWillShowNotification object:
     nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        self.textFieldsContainerViewBottomConstraint.constant = 2*self.bottomConstraint;
    
        [UIView animateWithDuration:kAnimationDuration animations:^{
             [self.view layoutIfNeeded];
        }];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:
     UIKeyboardWillHideNotification object:
     nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        self.textFieldsContainerViewBottomConstraint.constant = self.bottomConstraint;
         
         [UIView animateWithDuration:kAnimationDuration animations:^{
             [self.view layoutIfNeeded];
         }];
      }];
     }

#pragma mark - UIResponder

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - View lifecycle

-(void) viewDidLoad {
    [super viewDidLoad];
    
    self.bottomConstraint = self.textFieldsContainerViewBottomConstraint.constant;
    
    // zaokruzi kockasti view sivi
    self.logoView.layer.cornerRadius = self.logoView.frame.size.width/2;
    
    [self configurePlaceholders];
    [self registerForNotifications];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CGRect frame = [UIScreen mainScreen].bounds;
    self.confirmButtonLeadingConstraint.constant = frame.size.width;
    [self.view layoutIfNeeded];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.confirmButtonLeadingConstraint.constant = 0.0f;
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.logoView.alpha = 0.0f;
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - UITextFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField ==self.usernameTextField) {
        self.usernameImageView.image = [UIImage imageNamed:@"username-active"];
    } else if (textField == self.passwordTextField) {
        self.passwordImageView.image = [UIImage imageNamed:@"password-active"];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    self.usernameImageView.image = [UIImage imageNamed:@"username"];
    self.passwordImageView.image = [UIImage imageNamed:@"password"];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.usernameTextField) {
    [self.passwordTextField becomeFirstResponder];
    return NO;
   } else if (textField == self.passwordTextField) {
    //   self.textFieldsContainerViewBottomConstraint.constant = self.bottomConstraint;
      [textField resignFirstResponder];
   }
    return YES;
}

@end
