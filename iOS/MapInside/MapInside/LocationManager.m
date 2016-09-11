//
//  LocationManager.m
//  MapInside
//
//  Created by Stuckinaboot on 9/11/16.
//  Copyright © 2016 Stuckinaboot. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager

- (id)init {
    if (self = [super init]) {
        locManager = [[CLLocationManager alloc] init];
        [locManager setDelegate:self];
        [locManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [locManager setDistanceFilter:kCLDistanceFilterNone];
        
        if ([locManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [locManager requestWhenInUseAuthorization];
        }
    }
    return self;
}

- (void)startUpdating {
    [locManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if ([locations count] > 0) {
        lastKnownLocation = locations[0].coordinate;
        [self stopUpdating];
    }
}

- (CLLocationCoordinate2D)getLastKnownLocation {
    return lastKnownLocation;
}

- (void)stopUpdating {
    [locManager stopUpdatingLocation];
}

@end
