//
//  FloorPlanRecordingViewController.h
//  MapInside
//
//  Created by Stuckinaboot on 9/10/16.
//  Copyright © 2016 Stuckinaboot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FloorBackendManager.h"
#import "SCLAlertView.h"
#import "PulsingHaloLayer.h"
#import "FloorPlanPostRecordingViewController.h"

static const NSString *kSegueToPostRecording = @"RecordingToPostRecordingSegue";
@interface FloorPlanRecordingViewController : UIViewController {
    FloorBackendManager *backendManager;
    
    BOOL isWalking;
    
    IBOutlet UIButton *markPtBtn;
    IBOutlet UIImageView *pulsingHaloContainer;
    PulsingHaloLayer *pulsingHalo;
}
- (IBAction)markPoint:(id)sender;
- (IBAction)markPlaceOfInterest:(id)sender;
- (IBAction)done:(id)sender;
- (void)setUp;
- (void)beginRecording;
- (void)setVelocity:(float)vel;
@end
