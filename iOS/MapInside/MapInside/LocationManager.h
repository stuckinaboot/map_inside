//
//  LocationManager.h
//  MapInside
//
//  Created by Stuckinaboot on 9/11/16.
//  Copyright © 2016 Stuckinaboot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationManager : NSObject <CLLocationManagerDelegate> {
    CLLocationManager *locManager;
    CLLocationCoordinate2D lastKnownLocation;
}
- (void)startUpdating;
- (CLLocationCoordinate2D)getLastKnownLocation;
- (void)stopUpdating;
@end
