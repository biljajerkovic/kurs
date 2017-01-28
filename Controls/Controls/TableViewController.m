//
//  TableViewController.m
//  Controls
//
//  Created by Djuro Alfirevic on 1/27/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "TableViewController.h"
#import "CityTableViewCell.h"
#import "City.h"

@interface TableViewController() <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *southCitiesArray;
@end

@implementation TableViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    City *vranje = [[City alloc] initWithName:@"Vranje"
                                   population:@"20.000"];
    City *beograd = [[City alloc] initWithName:@"Beograd"
                                    population:@"2.000.000"];
    City *noviSad = [[City alloc] initWithName:@"Novi Sad"
                                    population:@"1.000.000"];
    self.southCitiesArray = @[vranje, beograd, noviSad];
    
    // Briše linije viška.
    self.tableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.southCitiesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    //City *city = self.southCitiesArray[indexPath.row];
    //cell.titleLabel.text = city.name;
    //cell.subtitleLabel.text = city.population;
    cell.city = self.southCitiesArray[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    City *city = self.southCitiesArray[indexPath.row];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"City" message:city.name preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"Clicked on: %@", city.name);
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 100.0f;
    }
    
    return 50.0f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Milan";
    }
    
    return @"Branka";
}

@end
