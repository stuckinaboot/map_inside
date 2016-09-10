//
//  CalibrationManager.h
//  MapInside
//
//  Created by Stuckinaboot on 9/10/16.
//  Copyright © 2016 Stuckinaboot. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;

@interface CalibrationManager : NSObject <CLLocationManagerDelegate> {
    CLLocation *startLocation;
    CLLocation *mostRecentLocation;
    CLLocationManager *locationManager;
    
    int numSeconds;
}
- (void)beginCalibration:(int)numSec;

//Should return the velocity in m/s
- (float)endCalibration;
@end
