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
#import "LGBluetooth/LGSingleDeviceManager.h"
#import "FloorPlanDisplayView.h"

static const float kNearestMultiple = 45.0f;
static const NSString *kSegueToPostRecording = @"RecordingToPostRecordingSegue";
@interface FloorPlanRecordingViewController : UIViewController {
    FloorBackendManager *backendManager;
    
    BOOL isWalking;
    
    IBOutlet UIButton *markPtBtn;
    IBOutlet UIImageView *pulsingHaloContainer;
    PulsingHaloLayer *pulsingHalo;
    
    LGSingleDeviceManager *singleDeviceManager;
    
    NSMutableString *fullOutput;
    
    NSTimer *updateTimer;
    
    IBOutlet FloorPlanDisplayView *floorPlanDisplayView;
    
    float lastMarkedDirection;
}
- (IBAction)markPoint:(id)sender;
- (IBAction)markPlaceOfInterest:(id)sender;
- (IBAction)done:(id)sender;
- (void)setUp;
- (void)beginRecording;
- (void)setVelocity:(float)vel;

- (void)setBluetoothDeviceManager:(LGSingleDeviceManager*)device;
@end
