//
//  StatisticsViewController.m
//  ToDo
//
//  Created by Biljana on 3/18/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "StatisticsViewController.h"

#define kBorderWidth 2.0f

@interface StatisticsViewController()
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UILabel *leftPercentageLabel;
@property (weak, nonatomic) IBOutlet UILabel *centerPercentageLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightPercentageLabel;
@property (weak, nonatomic) IBOutlet UILabel *complitedCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *notComplitedCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *inProgressCountLabel;
@end

@implementation StatisticsViewController

#pragma mark - Actions

- (IBAction)backButtonTapped {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Private API

- (void)configureUI {
    self.leftView.layer.borderWidth = kBorderWidth;
    self.leftView.layer.borderColor = kColorNotComplited.CGColor;
    
    self.centerView.layer.borderWidth = kBorderWidth;
    self.centerView.layer.borderColor = kColorCompleted.CGColor;
    
    self.rightView.layer.borderWidth = kBorderWidth;
    self.rightView.layer.borderColor = kColorInProgress.CGColor;
}

- (void)fillPercentage {
    CGFloat complitedCount = [DATA_MANAGER numberOfTasksPerTaskGroup:TaskGroupComplited];
    CGFloat notComplitedCount = [DATA_MANAGER numberOfTasksPerTaskGroup:TaskGroupNotComplited];
    CGFloat inProgressCount = [DATA_MANAGER numberOfTasksPerTaskGroup:TaskGroupInProgress];
    CGFloat totalCount = complitedCount + notComplitedCount + inProgressCount;
    
    if (notComplitedCount > 0) {
        self.leftPercentageLabel.text = [NSString stringWithFormat:@"%.0f", (notComplitedCount/totalCount)*100];
    } else {
        self.leftPercentageLabel.text = @"0";
    }
    
    if (complitedCount > 0) {
        self.centerPercentageLabel.text = [NSString stringWithFormat:@"%.0f", (complitedCount/totalCount)*100];
    } else {
        self.centerPercentageLabel.text = @"0";
    }
    
    if (inProgressCount > 0) {
        self.rightPercentageLabel.text = [NSString stringWithFormat:@"%.0f", (inProgressCount/totalCount)*100];
    } else {
        self.rightPercentageLabel.text = @"0";
    }
}

- (void)fillCounts {
    NSInteger complitedCount = [DATA_MANAGER numberOfTasksPerTaskGroup:TaskGroupComplited];
    self.complitedCountLabel.text = [NSString stringWithFormat:@"%ld", complitedCount];
    
    NSInteger notComplitedCount = [DATA_MANAGER numberOfTasksPerTaskGroup:TaskGroupNotComplited];
    self.notComplitedCountLabel.text = [NSString stringWithFormat:@"%ld", notComplitedCount];
    
    NSInteger inProgressCount = [DATA_MANAGER numberOfTasksPerTaskGroup:TaskGroupInProgress];
    self.inProgressCountLabel.text = [NSString stringWithFormat:@"%ld", inProgressCount];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureUI];
    [self fillCounts];
    [self fillPercentage];
}

@end
