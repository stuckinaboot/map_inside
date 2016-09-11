//
//  FloorPlanPreRecordingViewController.m
//  MapInside
//
//  Created by Stuckinaboot on 9/10/16.
//  Copyright © 2016 Stuckinaboot. All rights reserved.
//

#import "FloorPlanPreRecordingViewController.h"

#import "LGBluetooth/LGBluetooth.h"

@interface FloorPlanPreRecordingViewController ()

@end

@implementation FloorPlanPreRecordingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    singleDeviceManager = [[LGSingleDeviceManager alloc] init];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (![dataInputControl delegate]) {
        [dataInputControl setButtonNames:@[kDataInputControlTypeNameDevice, kDataInputControlTypeNameBluetooth]];
        [dataInputControl setDelegate:self];
    }
}

- (IBAction)calibrate:(id)sender {
    
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)start:(id)sender {
    
}

- (void)segmentedControl:(APSegmentedControl *)segmentedControl buttonSelectedForButtonName:(NSString *)btnName {
    if ([segmentedControl isEqual:dataInputControl]) {
        if ([btnName isEqualToString:kDataInputControlTypeNameBluetooth]) {
            if (!singleDeviceManager) {
                singleDeviceManager = [[LGSingleDeviceManager alloc] init];
            }
            
            [singleDeviceManager searchForDevice:kBluetoothDeviceID completion:^(BOOL deviceFound) {
                if (deviceFound) {
                    __block BOOL displayOnce = FALSE;
                    [singleDeviceManager subscribeToNotificationsForService:kBluetoothServiceID characteristic:kBluetoothCharacteristicID onUpdate:^(NSData *data, NSError *error) {
                        if (!error && !displayOnce) {
                            SCLAlertView *alert = [[SCLAlertView alloc] init];
                            [alert showSuccess:@"Bluetooth" subTitle:[NSString stringWithFormat:@"Successfully paired with %@.", kBluetoothDeviceID] closeButtonTitle:@"Dismiss" duration:0];
                        } else {
                            SCLAlertView *alert = [[SCLAlertView alloc] init];
                            [alert showError:@"Bluetooth" subTitle:[NSString stringWithFormat:@"Failed to initiate data transfer with %@.", kBluetoothDeviceID] closeButtonTitle:@"Dismiss" duration:0];
                        }
                        displayOnce = TRUE;
                    }];
                } else {
                    SCLAlertView *alert = [[SCLAlertView alloc] init];
                    [alert showError:self title:@"Bluetooth" subTitle:@"Failed to pair with compatible device." closeButtonTitle:@"Dismiss" duration:0];
                    [segmentedControl selectButtonAtIndex:0 animated:YES];
                }
            }];
        } else {
            
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kSegueToCalibrate]) {
        calibrationViewController = (CalibrationViewController*)segue.destinationViewController;
    } else if ([segue.identifier isEqualToString:kSegueToRecording]) {
        FloorPlanRecordingViewController *recordingVC = (FloorPlanRecordingViewController*)segue.destinationViewController;
        [recordingVC setUp];
        
        if ([[dataInputControl selectedButtonName] isEqualToString:kDataInputControlTypeNameBluetooth]) {
            [recordingVC setBluetoothDeviceManager:singleDeviceManager];
        } else {
            [recordingVC setBluetoothDeviceManager:NULL];
        }
        
        float velocity = 5.5f;
        if (calibrationViewController)
            velocity = [calibrationViewController getVelocity];
        [recordingVC setVelocity:velocity];
    }
}

@end
