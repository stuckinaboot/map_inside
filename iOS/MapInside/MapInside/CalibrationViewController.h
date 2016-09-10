//
//  CalibrationViewController.h
//  MapInside
//
//  Created by Stuckinaboot on 9/10/16.
//  Copyright © 2016 Stuckinaboot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalibrationManager.h"

static const int kCalibrationTimerUpdateInterval = 1;
static const int kCalibrationNumSeconds = 20;

static const NSString *kBtnStartInitialTxt = @"Start";
static const NSString *kBtnStartCountingTxt = @"%d seconds remaining";
static const NSString *kBtnStartFinishedTxt = @"Finished";

@interface CalibrationViewController : UIViewController {
    int numSecondsRemaining;
    NSTimer *calibrationTimer;
    
    CalibrationManager *calibrationManager;
    
    float velocity;
    
    IBOutlet UIButton *startBtn;
}
- (IBAction)startCalibrating:(id)sender;
- (IBAction)exit:(id)sender;
- (float)getVelocity;
@end
