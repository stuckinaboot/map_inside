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
#import "LGBluetooth/LGSingleDeviceManager.h"

@protocol FloorBackendManager <NSObject>
- (void)pathDataGenerated:(NSString*)pathDataStr;
@end
@interface FloorBackendManager : NSObject {
    PedometerManager *pedometerManager;
    CompassManager *compasssManager;
    NSMutableArray *path;
}
@property (nonatomic) id delegate;
- (void)startRecordingPath;
- (void)stopRecordingPath;
- (void)markPointOfInterest:(NSString*)pointName description:(NSString*)pointDescription;
- (NSString*)markPoint;

- (void)pauseRecording;
- (void)resumeRecording;

- (double)getCompassDirection;

- (void)setVelocity:(float)vel;
@end
