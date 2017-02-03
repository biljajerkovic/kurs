//
//  CalendarViewController.m
//  Calendar
//
//  Created by Djuro Alfirevic on 2/1/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "CalendarViewController.h"
#import "DateCollectionViewCell.h"
#import "EventTableViewCell.h"

@interface CalendarViewController() <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeightConstraint;
@property (strong, nonatomic) NSDate *currentDate;
@property (strong, nonatomic) NSMutableArray *itemsArray;
@property (strong, nonatomic) NSMutableArray *eventsArray;
@end

@implementation CalendarViewController

#pragma mark - Properties

- (void)setCurrentDate:(NSDate *)currentDate {
    _currentDate = currentDate;
    
    // When user sets current date, update month label
    self.monthLabel.text = [self getMonthFromDate:currentDate];
    [self configureDates];

    NSLog(@"Number of days in current month: %ld", (long)[self numberOfDaysForCurrentMonth]);
}

- (NSMutableArray *)itemsArray {
    if (!_itemsArray) {
        // We will always have 7 columns with 6 rows. If 1st of month is on Sunday, then we would have 6 rows
        _itemsArray = [[NSMutableArray alloc] initWithCapacity:42];
    }
    
    return _itemsArray;
}

- (NSMutableArray *)eventsArray {
    if (!_eventsArray) {
        _eventsArray = [[NSMutableArray alloc] init];
    }
    
    return _eventsArray;
}

#pragma mark - Actions

- (IBAction)previousButtonTapped {
    [self setValueForMonth:-1];
}

- (IBAction)nextButtonTapped {
    [self setValueForMonth:1];
}

#pragma mark - Private API

- (NSString *)getMonthFromDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MMMM yyyy";
    
    return [dateFormatter stringFromDate:date];
}

- (void)setValueForMonth:(NSInteger)value {
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    self.currentDate = [calendar dateByAddingUnit:NSCalendarUnitMonth
                                            value:value
                                           toDate:self.currentDate
                                          options:0];
}

- (void)configureDates {
    // Fill array with empty strings
    for (int i = 0; i < 42; i++) {
        self.itemsArray[i] = @"";
    }
    
    // Replace strings with actual dates
    NSInteger beginningIndex = [self indexOfFirstDayInCurrentMonth];
    NSInteger endingIndex = beginningIndex + [self numberOfDaysForCurrentMonth];
    NSLog(@"BEGIN: %ld, END: %ld", (long)beginningIndex, (long)endingIndex);
    
    NSInteger day = 1;
    for (NSInteger i = beginningIndex; i < endingIndex; i++) {
        NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *dateComponents = [calendar components:NSCalendarUnitMonth|NSCalendarUnitYear fromDate:self.currentDate];
        dateComponents.day = day;
        
        self.itemsArray[i] = [calendar dateFromComponents:dateComponents];
        
        day = day+1;
    }
    
    // Reload collection view
    [self.collectionView reloadData];
}

- (void)configureEvents:(NSInteger)end {
    [self.eventsArray removeAllObjects];
    
    for (NSInteger i = 1; i < end; i++) {
        [self.eventsArray addObject:[NSString stringWithFormat:@"Event %ld", (long)i]];
    }
    
    [self.tableView reloadData];
}

- (NSInteger)indexOfFirstDayInCurrentMonth {
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitMonth|NSCalendarUnitYear fromDate:self.currentDate];
    dateComponents.day = 1;
    
    // Now we have the first day in current month and year
    NSDate *date = [calendar dateFromComponents:dateComponents];
    
    NSDateComponents *dateComponents2 = [calendar components:NSCalendarUnitWeekday fromDate:date];
    
    return [self fixAmericanWeekdayForSerbianWeekday:dateComponents2.weekday];
}

- (NSInteger)fixAmericanWeekdayForSerbianWeekday:(NSInteger)weekday {
    switch (weekday) {
        case 1: return 6; break; // Sunday
        case 2: return 0; break; // Monday
        case 3: return 1; break; // Tuesday
        case 4: return 2; break; // Wednesday
        case 5: return 3; break; // Thursday
        case 6: return 4; break; // Friday
        case 7: return 5; break; // Saturday
    }
    
    return 0;
}

- (NSInteger)numberOfDaysForCurrentMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange days = [calendar rangeOfUnit:NSCalendarUnitDay
                                  inUnit:NSCalendarUnitMonth
                                 forDate:self.currentDate];
    
    return days.length;
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // On load, set current date as today's date
    self.currentDate = NSDate.date;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat width = self.collectionView.frame.size.width/7;
    self.collectionViewHeightConstraint.constant = 6 * width;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.item = self.itemsArray[indexPath.item];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self configureEvents:indexPath.item];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = collectionView.frame.size.width/7;
    CGFloat height = width;
    
    return CGSizeMake(width, height);
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.eventsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.event = self.eventsArray[indexPath.row];
    
    return cell;
}

@end
