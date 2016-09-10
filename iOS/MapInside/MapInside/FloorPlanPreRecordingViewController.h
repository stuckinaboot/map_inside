//
//  FloorPlanPreRecordingViewController.h
//  MapInside
//
//  Created by Stuckinaboot on 9/10/16.
//  Copyright © 2016 Stuckinaboot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalibrationViewController.h"
#import "FloorPlanRecordingViewController.h"

static const NSString *kSegueToCalibrate = @"PreRecordingToCalibrateSegue";
static const NSString *kSegueToRecording = @"PreRecordingToRecordingSegue";
@interface FloorPlanPreRecordingViewController : UIViewController {
    CalibrationViewController *calibrationViewController;
}
- (IBAction)calibrate:(id)sender;
- (IBAction)start:(id)sender;
@end
