//
//  ContainerViewController.m
//  ToDo
//
//  Created by Biljana on 3/17/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "ContainerViewController.h"
#import "SideMenuViewController.h"

@interface ContainerViewController ()
@property (strong, nonatomic) UIButton *overlayButton;
@property (strong, nonatomic) SideMenuViewController *sideMenuViewController;
@end

@implementation ContainerViewController

#pragma mark - Actions

- (void)overlayButtonTapped {
    [[NSNotificationCenter defaultCenter] postNotificationName:CLOSE_SIDE_MENU_NOTIFICATION object:nil];
}

# pragma mark - Private API

- (void)configureSideMenuViewController {
    UIViewController *sideMenuViewController = [Helpers initViewControllerFrom:@"SideMenuViewController"];
    
    // View controller containment
    [self addChildViewController:sideMenuViewController];
    [self.view addSubview:sideMenuViewController.view];
    [sideMenuViewController didMoveToParentViewController:self]; //da bi se pozvale life cycle metode
    
    // Hide menu
    CGRect frame = sideMenuViewController.view.frame;
    frame.origin.x = -self.view.frame.size.width;
    sideMenuViewController.view.frame = frame;
    
    self.sideMenuViewController = (SideMenuViewController *)sideMenuViewController;
}

- (void)configureOverlayButton {
    UIButton *overlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    overlayButton.frame = self.view.frame;
    overlayButton.backgroundColor = [UIColor blackColor];
    overlayButton.alpha = 0.0f; //u pocetku ne treba da se vidi, stavljamo alpha 0
    [overlayButton addTarget:self action:@selector(overlayButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:overlayButton];
    
    self.overlayButton = overlayButton;
}

- (void)configureHomeViewController {
    UIViewController *homeViewController = [Helpers initViewControllerFrom:@"HomeViewController"];
    
    // View controller containment
    [self addChildViewController:homeViewController];
    [self.view addSubview:homeViewController.view];
    [homeViewController didMoveToParentViewController:self]; //da bi se pozvale life cycle metode
    
}

- (void)registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserverForName:OPEN_SIDE_MENU_NOTIFICATION object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        [UIView animateWithDuration:kAnimationDuration animations:^{
            self.overlayButton.alpha = 0.3f;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:kAnimationDuration animations:^{
                CGRect frame = self.sideMenuViewController.view.frame;
                frame.origin.x = 50.0f;
                self.sideMenuViewController.view.frame = frame;
            }];
        }];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:CLOSE_SIDE_MENU_NOTIFICATION object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        [UIView animateWithDuration:kAnimationDuration animations:^{
            CGRect frame = self.sideMenuViewController.view.frame;
            frame.origin.x = -self.view.frame.size.width;
            self.sideMenuViewController.view.frame = frame;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:kAnimationDuration animations:^{
                self.overlayButton.alpha = 0.0f;
            }];
        }];
    }];
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureHomeViewController];
    [self configureOverlayButton];
    [self configureSideMenuViewController];
}

@end
