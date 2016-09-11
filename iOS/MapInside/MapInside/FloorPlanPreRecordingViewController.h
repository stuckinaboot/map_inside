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
#import "APSegmentedControl.h"
#import "SCLAlertView/SCLAlertView.h"

#import "LGBluetooth/LGSingleDeviceManager.h"

static const NSString *kSegueToCalibrate = @"PreRecordingToCalibrateSegue";
static const NSString *kSegueToRecording = @"PreRecordingToRecordingSegue";

static const NSString *kDataInputControlTypeNameDevice = @"Device";
static const NSString *kDataInputControlTypeNameBluetooth = @"Bluetooth";

static const NSString *kBluetoothDeviceID = @"Adafruit Bluefruit LE";
static const NSString *kBluetoothServiceID = @"6e400001-b5a3-f393-e0a9-e50e24dcca9e";
static const NSString *kBluetoothCharacteristicID = @"6e400003-b5a3-f393-e0a9-e50e24dcca9e";

@interface FloorPlanPreRecordingViewController : UIViewController <APSegmentedControlDelegate> {
    CalibrationViewController *calibrationViewController;
    
    IBOutlet APSegmentedControl *dataInputControl;
    
    LGSingleDeviceManager *singleDeviceManager;
}
- (IBAction)calibrate:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)start:(id)sender;
@end
