//
//  CompassManager.m
//  MapInside
//
//  Created by Stuckinaboot on 9/10/16.
//  Copyright © 2016 Stuckinaboot. All rights reserved.
//

#import "CompassManager.h"

@implementation CompassManager

- (id)init {
    if (self = [super init]) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [locationManager setDelegate:self];
    }
    return self;
}

- (void)startRecordingDirection {
    [locationManager startUpdatingHeading];
}

- (void)stopRecordingDirection {
    [locationManager stopUpdatingHeading];
}

- (double)getCurrentDirection {
    return currentDirection;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    currentDirection = newHeading.magneticHeading;
}

@end
