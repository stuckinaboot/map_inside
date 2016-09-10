//
//  PedometerManager.m
//  MapInside
//
//  Created by Stuckinaboot on 9/10/16.
//  Copyright © 2016 Stuckinaboot. All rights reserved.
//

#import "PedometerManager.h"

@implementation PedometerManager

- (id)init {
    if (self = [super init]) {
        velocity = 5.5f;
    }
    return self;
}

- (void)startRecordingSteps {
    startTime = [[NSDate date] timeIntervalSince1970];
}

- (float)stopRecordingSteps {
    endTime = [[NSDate date] timeIntervalSince1970];
    float deltaTime = endTime - startTime;
    float totalDistance = velocity * deltaTime;

    return totalDistance;
}

- (void)setVelocity:(float)vel {
    velocity = vel;
}

@end
