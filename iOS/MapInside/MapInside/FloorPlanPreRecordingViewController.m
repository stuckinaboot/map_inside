//
//  FloorPlanPreRecordingViewController.m
//  MapInside
//
//  Created by Stuckinaboot on 9/10/16.
//  Copyright © 2016 Stuckinaboot. All rights reserved.
//

#import "FloorPlanPreRecordingViewController.h"

@interface FloorPlanPreRecordingViewController ()

@end

@implementation FloorPlanPreRecordingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)calibrate:(id)sender {
    
}

- (IBAction)start:(id)sender {
    
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
        
        float velocity = 5.5f;
        if (calibrationViewController)
            velocity = [calibrationViewController getVelocity];
        [recordingVC setVelocity:velocity];
    }
}

@end
