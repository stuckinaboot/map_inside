//
//  FloorBackendManager.h
//  MapInside
//
//  Created by Stuckinaboot on 9/10/16.
//  Copyright © 2016 Stuckinaboot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CompassManager.h"
#import "PedometerManager.h"

@interface FloorBackendManager : NSObject {
    PedometerManager *pedometerManager;
    CompassManager *compasssManager;
    NSMutableArray *path;
}
- (void)startRecordingPath;
- (NSArray*)stopRecordingPath;
- (void)markPointOfInterest:(NSString*)pointName description:(NSString*)pointDescription;
- (void)markPoint;

- (void)pauseRecording;
- (void)resumeRecording;

- (void)setVelocity:(float)vel;
@end
