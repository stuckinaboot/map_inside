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
        
        path = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)startRecordingPath {
    [pedometerManager startRecordingSteps];
}

- (void)stopRecordingPath {
    [pedometerManager stopRecordingSteps];
//    return path;
}

- (void)markPointOfInterest:(NSString*)pointName description:(NSString*)pointDescription {
    [path addObject:@{pointName: pointDescription}];
}

- (NSString*)markPoint {
    float totalDistance = [pedometerManager stopRecordingSteps];
    NSArray *dataPoint = @[@(totalDistance), @([compasssManager getCurrentDirection])];
    [path addObject:dataPoint];
    
    NSString *travelStr = [NSString stringWithFormat:@"l: 1, r: 1, f: 0, time: %f, %.02f", [[NSDate date] timeIntervalSince1970], [compasssManager getCurrentDirection]];
    
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
