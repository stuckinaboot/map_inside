//
//  CalibrationManager.m
//  MapInside
//
//  Created by Stuckinaboot on 9/10/16.
//  Copyright © 2016 Stuckinaboot. All rights reserved.
//

#import "CalibrationManager.h"

@implementation CalibrationManager

- (id)init {
    if (self = [super init]) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        [locationManager startUpdatingLocation];
    }
    return self;
}

- (void)beginCalibration:(int)numSec {
    startLocation = mostRecentLocation;
    numSeconds = numSec;
}

- (float)endCalibration {
    CLLocation *endLocation = mostRecentLocation;
    
    CLLocationDistance distance = [endLocation distanceFromLocation:startLocation];
    [locationManager stopUpdatingLocation];
    
    return distance / numSeconds;
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    mostRecentLocation = [locations lastObject];
}

@end
