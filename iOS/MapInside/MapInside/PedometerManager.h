//
//  PedometerManager.h
//  MapInside
//
//  Created by Stuckinaboot on 9/10/16.
//  Copyright © 2016 Stuckinaboot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

@interface PedometerManager : NSObject {
    float velocity;
    
    NSTimeInterval startTime;
    NSTimeInterval endTime;
}
- (void)startRecordingSteps;
- (float)stopRecordingSteps;

- (void)setVelocity:(float)vel;
@end
