//
//  SideMenuViewController.m
//  ToDo
//
//  Created by Biljana on 3/17/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "SideMenuViewController.h"
#import "SideManuTableViewCell.h"

@interface SideMenuViewController () <UITableViewDataSource, UITabBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *itemsArray;
@end

@implementation SideMenuViewController

#pragma mark - Actions

- (IBAction)closeButtonTapped:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:CLOSE_SIDE_MENU_NOTIFICATION object:nil];
}

#pragma mark - View lifecycle

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.itemsArray = @[@"Home", @"Walkthrough", @"Statistics", @"Add TAsk", @"Log Out"];
}

#pragma  mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SideManuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.subtitleLabel.hidden = (indexPath.row ==0) ? NO : YES; // prikazana samo na prvoj celiji
    cell.subtitleLabel.text = [NSString stringWithFormat:@"%ld", [DATA_MANAGER numberOfTasksForToday]]; //broj taskova
    cell.titeLabel.text = self.itemsArray[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
