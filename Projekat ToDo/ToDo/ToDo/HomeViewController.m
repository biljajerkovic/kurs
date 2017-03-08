//
//  HomeViewController.m
//  ToDo
//
//  Created by Biljana on 2/11/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "HomeViewController.h"
#import "DateCollectionViewCell.h"
#import "TaskTableViewCell.h"

@interface HomeViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *taskLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthYearLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *datesArray;
@property (strong, nonatomic) NSArray *tasksArray;
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
    
    [self configureCalendar];
    [self configureTasks];
}

#pragma mark - Actions

- (IBAction)menuButtonTapped {
    
}

- (IBAction)searchButtonTapped {
    
}

- (IBAction)previousButtonTapped {
    [self updateMonth:-1];
}

- (IBAction)nextButtonTapped {
    [self updateMonth:1];
}

- (IBAction)userImageViewTapped:(UITapGestureRecognizer *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Choose source:" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //Photo Library
    UIAlertAction *photoLibraryAction = [UIAlertAction actionWithTitle:@"Photo Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        if (picker) {
            picker.allowsEditing = YES;
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:picker animated:YES completion:nil];
        }
    }];
    [alertController addAction:photoLibraryAction];
    
    // Camera
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            if (picker) {
                picker.allowsEditing = YES;
                picker.delegate = self;
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:picker animated:YES completion:nil];
            }
        }];
        [alertController addAction:cameraAction];
    }
    
    // Cancel
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
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
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = DATE_FORMAT;
    
    NSString *filter = [NSString stringWithFormat:@"date LIKE '%@'", [dateFormatter stringFromDate:self.selectedDate]];
    
    self.tasksArray = [[DataManager sharedManager] fetchEntity:NSStringFromClass (DBTask.class) withFilter:filter withSortAsc:YES forKey:@"date"];
    [self.tableView reloadData];
}

- (void)configureCalendar {
    [self.datesArray removeAllObjects];
    self.monthYearLabel.text = [Helpers valueFrom:self.selectedDate withFormat:@"MMMM yyyy"].uppercaseString;
    
    NSInteger days = [Helpers numberOfDaysInMonthForDate:self.selectedDate];
    
    for (int i = 1; i <= days; i++) {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *dateComponents = [calendar components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:self.selectedDate];
        
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
    NSInteger currentDay = [[NSCalendar currentCalendar] component:NSCalendarUnitDay fromDate:self.selectedDate];
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:currentDay-1 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
   // });
}

- (void)updateMonth:(NSInteger)value {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:self.selectedDate];
    dateComponents.day = 1;
    dateComponents.month += value; //+1, da je pisalo +=5 povecalo bi se za 5
    
    self.selectedDate = [calendar dateFromComponents:dateComponents];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureWelcomeLabel];
    [self configureUserImage];
    self.tableView.tableFooterView = [[UIView alloc] init]; // da nemamo linije ispod celija
    
    //Load image from NSUserDefaults
    if ([[NSUserDefaults standardUserDefaults]objectForKey:USER_IMAGE]) {
        NSData *data = [[NSUserDefaults standardUserDefaults]objectForKey:USER_IMAGE];
        UIImage *image = [[UIImage alloc]initWithData:data];
        self.userImageView.image = image;
    }
}

- (void)viewWillAppear:(BOOL)animated { //da se setuju taskovi cim kliknemo na add,odnosno kad setuje datum ucitava task
    [super viewWillAppear:animated];
    
    self.selectedDate = [NSDate date];
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
    return self.tasksArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.task = self.tasksArray[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //posto smo gore omugucili da moze da se edituje, ali i ako nismo pise se ovako
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (!image) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    
    self.userImageView.image = image;
    
    //Store image to NSUserDefaults
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:USER_IMAGE];
    [[NSUserDefaults standardUserDefaults] synchronize]; //ovo radimo kako bi odmah presao u NSUserDefault, inace ako ga nesto rpekine, nece se sacuvati. Uvek ovo pisemo!
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
