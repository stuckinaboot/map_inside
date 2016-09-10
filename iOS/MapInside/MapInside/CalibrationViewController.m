//
//  CalibrationViewController.m
//  MapInside
//
//  Created by Stuckinaboot on 9/10/16.
//  Copyright © 2016 Stuckinaboot. All rights reserved.
//

#import "CalibrationViewController.h"

@interface CalibrationViewController ()

@end

@implementation CalibrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [startBtn.titleLabel setNumberOfLines:3];
    [startBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
}

- (void)viewDidAppear:(BOOL)animated {
    [startBtn setTitle:kBtnStartInitialTxt forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startCalibrating:(id)sender {
    calibrationManager = [[CalibrationManager alloc] init];
    
    numSecondsRemaining = kCalibrationNumSeconds;
    [calibrationManager beginCalibration:numSecondsRemaining];
    
    calibrationTimer = [NSTimer scheduledTimerWithTimeInterval:kCalibrationTimerUpdateInterval target:self selector:@selector(timerUpdate) userInfo:nil repeats:YES];
}

- (void)timerUpdate {
    if (numSecondsRemaining == 0) {
        [startBtn setTitle:kBtnStartFinishedTxt forState:UIControlStateNormal];
        [calibrationTimer invalidate];
        calibrationTimer = nil;
        
        velocity = [calibrationManager endCalibration];
    } else {
        [startBtn setTitle:[NSString stringWithFormat:kBtnStartCountingTxt, numSecondsRemaining] forState:UIControlStateNormal];
        numSecondsRemaining--;
    }
}

- (float)getVelocity {
    return velocity;
}

- (IBAction)exit:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
