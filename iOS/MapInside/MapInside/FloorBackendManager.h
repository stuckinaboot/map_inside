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
#import "LocationManager.h"
#import "LGBluetooth/LGSingleDeviceManager.h"

@protocol FloorBackendManager <NSObject>
- (void)pathDataGenerated:(NSString*)pathDataStr;
@end
@interface FloorBackendManager : NSObject {
    PedometerManager *pedometerManager;
    CompassManager *compasssManager;
    LocationManager *locationManager;
    NSMutableArray *path;
    
    CLLocationCoordinate2D lastKnownLocation;
}
@property (nonatomic) id delegate;
- (void)startRecordingPath;
- (void)stopRecordingPath;
- (void)markPointOfInterest:(NSString*)pointName description:(NSString*)pointDescription;
- (NSString*)markPoint:(float)direction;

- (void)pauseRecording;
- (void)resumeRecording;

- (CLLocationCoordinate2D)getLastKnownLocation;

- (double)getCompassDirection;

- (void)setVelocity:(float)vel;
@end
