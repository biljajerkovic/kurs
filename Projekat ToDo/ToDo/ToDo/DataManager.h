//
//  DataManager.h
//  ToDo
//
//  Created by Biljana on 2/25/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>
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
@end
