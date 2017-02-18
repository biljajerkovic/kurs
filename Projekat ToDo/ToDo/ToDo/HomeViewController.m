//
//  HomeViewController.m
//  ToDo
//
//  Created by Biljana on 2/11/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "HomeViewController.h"
#import "Helpers.h"
#import "DateCollectionViewCell.h"

@interface HomeViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *taskLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthYearLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *datesArray;
@property (strong, nonatomic) NSDate *selectedDate;
@end

@implementation HomeViewController

#pragma mark - Properties

- (NSMutableArray *)datesArray {
    if (!_datesArray) {
        _datesArray = [[NSMutableArray alloc]init];
    }
    return _datesArray;
}

- (void)setSelectedDate:(NSDate *)selectedDate {
    _selectedDate = selectedDate;
    
    [self.tableView reloadData];
}

#pragma mark - Actions

- (IBAction)menuButtonTapped {
    
}

- (IBAction)searchButtonTapped {
    
}

- (IBAction)previousButtonTapped {
    
}

- (IBAction)nextButtonTapped {
    
}

#pragma mark - Private API

- (void)configureWelcomeLabel {
    if ([Helpers isMorning]) {
        self.welcomeLabel.text = @"Good Morning!";
    } else {
        self.welcomeLabel.text = @"Good Afternoon!";
    }
}

- (void)configureTasks {
    
}

- (void)configureCalendar {
    self.monthYearLabel.text = [Helpers valueFrom:[NSDate date] withFormat:@"MMMM yyyy"].uppercaseString;
    self.selectedDate = [NSDate date];
    
    NSInteger days = [Helpers numberOfDaysInMonthForDate:[NSDate date]];
    
    for (int i = 1; i <= days; i++) {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *dateComponents = [calendar components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:[NSDate date]];
        
        dateComponents.day = i;
        NSDate *date = [calendar dateFromComponents:dateComponents];
        [self.datesArray addObject:date];
    }
    [self.collectionView reloadData];
    [self performSelector:@selector(scrollToCurrentDay) withObject:nil afterDelay:0.25];
}

- (void)configureUserImage {
    
}

- (void)scrollToCurrentDay {
   // dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSInteger currentDay = [[NSCalendar currentCalendar] component:NSCalendarUnitDay fromDate:[NSDate date]];
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:currentDay-1 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
   // });
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureWelcomeLabel];
    [self configureTasks];
    [self configureCalendar];
    [self configureUserImage];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.date = self.datesArray[indexPath.row];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedDate = self.datesArray[indexPath.item];
}

#pragma  mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
