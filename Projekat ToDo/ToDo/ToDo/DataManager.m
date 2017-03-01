//
//  DataManager.m
//  ToDo
//
//  Created by Biljana on 2/25/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "DataManager.h"

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

#pragma mark -

+ (instancetype)sharedManager {
    static DataManager *shared;
    
    @synchronized (self) {
        if (shared == nil) {
            shared = [[DataManager alloc]init];
        }
    }
    
    return shared;
}

@end
