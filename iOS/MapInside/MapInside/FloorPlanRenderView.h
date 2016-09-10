//
//  FloorPlanRenderView.h
//  MapInside
//
//  Created by Stuckinaboot on 9/10/16.
//  Copyright © 2016 Stuckinaboot. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DEGREES_TO_RADIANS(degrees)((M_PI * degrees)/180)

@interface FloorPlanRenderView : UIImageView {
    UIImageView *imgView;
}
- (void)renderFloorPlan:(NSString*)jsonRepresentation;
@end
