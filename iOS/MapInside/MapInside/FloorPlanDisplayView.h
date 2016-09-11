//
//  FloorPlanDisplayView.h
//  MapInside
//
//  Created by Stuckinaboot on 9/11/16.
//  Copyright © 2016 Stuckinaboot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define DEGREES_TO_RADIANS(degrees)((M_PI * degrees)/180)

@interface FloorPlanDisplayView : UIImageView {
    CGPoint prevPt;
    float startAngle;
}
- (void)setUp;
- (void)updateDrawingForTravelStr:(NSString*)travelStr;
@end
