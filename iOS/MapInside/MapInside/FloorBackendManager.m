//
//  FloorBackendManager.m
//  MapInside
//
//  Created by Stuckinaboot on 9/10/16.
//  Copyright © 2016 Stuckinaboot. All rights reserved.
//

#import "FloorBackendManager.h"

@implementation FloorBackendManager

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

- (NSArray*)stopRecordingPath {
    return path;
}

- (void)markPointOfInterest:(NSString*)pointName description:(NSString*)pointDescription {
    [path addObject:@{pointName: pointDescription}];
}

- (void)markPoint {
    float totalDistance = [pedometerManager stopRecordingSteps];
    NSArray *dataPoint = @[@(totalDistance), @([compasssManager getCurrentDirection])];
    [path addObject:dataPoint];
    
    [pedometerManager startRecordingSteps];
}

- (void)pauseRecording {
    [pedometerManager stopRecordingSteps];
}

- (void)resumeRecording {
    [pedometerManager startRecordingSteps];
}

- (void)setVelocity:(float)vel {
    [pedometerManager setVelocity:vel];
}

@end
