//
//  FloorPlanPostRecordingViewController.h
//  MapInside
//
//  Created by Stuckinaboot on 9/10/16.
//  Copyright © 2016 Stuckinaboot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FloorPlanDisplayView.h"

@interface FloorPlanPostRecordingViewController : UIViewController {
    IBOutlet FloorPlanDisplayView *floorPlanDisplayView;
    
    NSString *floorPlanFullOutput;
    BOOL renderedFloorPlan;
}
- (IBAction)done:(id)sender;
- (void)setFloorPlanFullOutput:(NSString*)output;
@end
