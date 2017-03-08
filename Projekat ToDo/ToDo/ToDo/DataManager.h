//
//  DataManager.h
//  ToDo
//
//  Created by Biljana on 2/25/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <CoreLocation/CoreLocation.h>

@protocol DataManagerDelegate <NSObject>
@optional
- (void)dataManagerDidUpdateLocality;
@end

@interface DataManager : NSObject
@property (strong, nonatomic) CLLocation *userLocation;
@property (strong, nonatomic) NSString *userLocality;
@property (weak, nonatomic) id<DataManagerDelegate> delegate;
+ (instancetype)sharedManager;

// CRUD metode (create, read, update, delete) - uvek kad radimo sa bazom ove metode koristimo
- (NSArray *)fetchEntity:(NSString *)entityName
                     withFilter:(NSString *)filter
                    withSortAsc:(BOOL)sortAscending
                         forKey:(NSString *)sortKey;
- (void)deleteObject:(NSManagedObject *)object;
- (void)updateObject:(NSManagedObject *)object;
- (void)logObject:(NSManagedObject *)object;
- (NSInteger)numberOfTasksPerTaskGroup:(TaskGroup)group;
- (void)saveTaskWithTitle:(NSString *)title
              description:(NSString *)description
                    group:(NSInteger)group;
@end
