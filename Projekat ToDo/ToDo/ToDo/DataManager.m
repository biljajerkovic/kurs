//
//  DataManager.m
//  ToDo
//
//  Created by Biljana on 2/25/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "DataManager.h"
#import "AppDelegate.h"

@interface DataManager()
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@end

@implementation DataManager

#pragma mark - Properties

- (void)setUserLocation:(CLLocation *)userLocation {
    _userLocation = userLocation;
    
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:userLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            NSLog(@"CLGeocoder error: %@", error.localizedDescription);
        }
        
        if (placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks firstObject];
            
            self.userLocality = placemark.locality;
            
            NSLog(@"ISOcountryCode: %@", placemark.ISOcountryCode);
            NSLog(@"Country: %@", placemark.country);
            NSLog(@"Postal code: %@", placemark.postalCode);
            NSLog(@"Locality: %@", placemark.subLocality);
            //i ima ih jos dosta

        }
    }];
}

- (void)setUserLocality:(NSString *)userLocality {
    _userLocality = userLocality;
    
    // VIA DELEGATE
    if (self.delegate) {
        [self.delegate dataManagerDidUpdateLocality];
    }
    
    // VIA NOTIFICATION
    [[NSNotificationCenter defaultCenter] postNotificationName:LOCALITY_UPDATED_NOTIFICATION object:nil];
}

- (NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        _managedObjectContext = appDelegate.persistentContainer.viewContext;
    }
    return _managedObjectContext;
}
#pragma mark - Designated Initializer

+ (instancetype)sharedManager {
    static DataManager *shared;
    
    @synchronized (self) {
        if (shared == nil) {
            shared = [[DataManager alloc]init];
        }
    }
    
    return shared;
}

#pragma mark - Public API

- (NSMutableArray *)fetchEntity:(NSString *)entityName withFilter:(NSString *)filter withSortAsc:(BOOL)sortAscending forKey:(NSString *)sortKey {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init]; //kreiramo objekat fetchRequest
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext]; //kreiramo entityDescription za odredjeni entitet u zadatom objectContext-u
    [fetchRequest setEntity:entityDescription]; //setuj fetchRequest za entityDescription (koji objekat izvlacimo iz baze)
    
    // Sorting
    if (sortKey) {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortKey ascending:sortAscending]; //ako postoji sortKey kreiraj sortDescriptor sa kljucem (atributom), moze da postoji vise filtera odnosno kljuceva, uzlazno ili silazno
        [fetchRequest setSortDescriptors:@[sortDescriptor]]; //setuj fetchRequest sa sortDescriptorima iz niza
    }
    
    // Filtering
    if (filter) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:filter];
        [fetchRequest setPredicate:predicate];
    }
    
    // Execute fetch request
    NSError *error; //prazan objekat error
    NSArray *resultsArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        NSLog(@"Error fetching: %@", error.localizedDescription);
    }
    
    return [resultsArray mutableCopy];
}

- (void)deleteObject:(NSManagedObject *)object {
    [self.managedObjectContext deleteObject:object];
    [self.managedObjectContext save:nil];
}

- (void)updateObject:(NSManagedObject *)object {
    [object.managedObjectContext save:nil];
}

- (void)logObject:(NSManagedObject *)object {
    NSEntityDescription *description = object.entity;
    NSDictionary *attributes = [description attributesByName];
    
    for (NSString *attribute in attributes) {
        NSLog(@"%@ = %@,", attribute, [object valueForKey:attribute]); //ispisi atribut sa njegovom vrednoscu pod tim atributom
    }
    
}
- (NSInteger)numberOfTasksPerTaskGroup:(TaskGroup)group {
    NSString *filter = [NSString stringWithFormat:@"group = %ld", group];
    
    NSArray *taskArray = [self fetchEntity:NSStringFromClass([DBTask class]) withFilter:filter withSortAsc:NO forKey:nil];
    
    return taskArray.count;
}

- (void)saveTaskWithTitle:(NSString *)title
              description:(NSString *)description
                    group:(NSInteger)group {
    DBTask *task = (DBTask *)[NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([DBTask class]) inManagedObjectContext:self.managedObjectContext];
    task.heading = title;
    task.desc = description;
    
    if (self.userLocation) {
        task.latitude = self.userLocation.coordinate.latitude;
        task.longitude = self.userLocation.coordinate.longitude;
    }
    
    // Date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = DATE_FORMAT;
    task.date = [dateFormatter stringFromDate:[NSDate date]];
    
    task.group = group;
    
    // Save
    [task.managedObjectContext save:nil];
}

@end
