//
//  FloorBackendManager.m
//  MapInside
//
//  Created by Stuckinaboot on 9/10/16.
//  Copyright © 2016 Stuckinaboot. All rights reserved.
//

#import "FloorBackendManager.h"

@implementation FloorBackendManager

@synthesize delegate;

- (id)init {
    if (self = [super init]) {
        pedometerManager = [[PedometerManager alloc] init];

        compasssManager = [[CompassManager alloc] init];
        [compasssManager startRecordingDirection];
        
        locationManager = [[LocationManager alloc] init];
        
        path = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)startRecordingPath {
    [locationManager startUpdating];
    [pedometerManager startRecordingSteps];
}

- (void)stopRecordingPath {
    lastKnownLocation = [locationManager getLastKnownLocation];
    [pedometerManager stopRecordingSteps];
//    return path;
}

- (CLLocationCoordinate2D)getLastKnownLocation {
    return lastKnownLocation;
}

- (void)markPointOfInterest:(NSString*)pointName description:(NSString*)pointDescription {
    [path addObject:@{pointName: pointDescription}];
}

- (NSString*)markPoint:(float)direction {
    float totalDistance = [pedometerManager stopRecordingSteps];
    NSArray *dataPoint = @[@(totalDistance), @(direction)];
    [path addObject:dataPoint];
    
    NSString *travelStr = [NSString stringWithFormat:@"l: 1, r: 1, f: 0, time: %d, angle: %.02f", (int)[[NSDate date] timeIntervalSince1970], direction];
    
    [pedometerManager startRecordingSteps];
    
    return travelStr;
}

- (void)pauseRecording {
    [pedometerManager stopRecordingSteps];
}

- (void)resumeRecording {
    [pedometerManager startRecordingSteps];
}

- (double)getCompassDirection {
    return [compasssManager getCurrentDirection];
}

- (void)setVelocity:(float)vel {
    [pedometerManager setVelocity:vel];
}

@end
