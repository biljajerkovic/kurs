//
//  AppDelegate.m
//  ToDo
//
//  Created by Administrator on 14/12/2016.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate() <CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;
@end

@implementation AppDelegate

#pragma mark - Private API

- (void)configureLocationManager {
    
    if (![CLLocationManager locationServicesEnabled]) return;

    self.locationManager = [[CLLocationManager alloc]init]; //inicijalizujemo ga
    self.locationManager.delegate = self; //mi smo njegov delegat
    self.locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters; //na svakih 10m belezi promenu
    [self.locationManager requestWhenInUseAuthorization]; //samo kada je u radi trazi lokaciju
    [self.locationManager startUpdatingLocation]; //belezi znacajne promene startmonitoringsigni
}

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self configureLocationManager];
    
    return YES;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if (locations.count > 0) {
        DataManager *dataManager = [DataManager sharedManager];
        dataManager.userLocation = [locations lastObject];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"LOcation manager: %@", error.localizedDescription);
}

@end
