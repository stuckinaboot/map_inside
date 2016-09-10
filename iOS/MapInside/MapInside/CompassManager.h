//
//  CompassManager.h
//  MapInside
//
//  Created by Stuckinaboot on 9/10/16.
//  Copyright © 2016 Stuckinaboot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface CompassManager : NSObject <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    double currentDirection;
}
- (void)startRecordingDirection;
- (void)stopRecordingDirection;
- (double)getCurrentDirection;
@end
