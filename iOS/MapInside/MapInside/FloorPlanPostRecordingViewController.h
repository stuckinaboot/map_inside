//
//  FloorPlanPostRecordingViewController.h
//  MapInside
//
//  Created by Stuckinaboot on 9/10/16.
//  Copyright © 2016 Stuckinaboot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FloorPlanRenderView.h"

@interface FloorPlanPostRecordingViewController : UIViewController {
    IBOutlet FloorPlanRenderView *floorPlanRenderView;
    
    NSString *floorPlanFullOutput;
}
- (IBAction)done:(id)sender;
- (void)setFloorPlanFullOutput:(NSString*)output;
@end
