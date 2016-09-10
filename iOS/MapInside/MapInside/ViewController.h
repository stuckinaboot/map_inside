//
//  ViewController.h
//  MapInside
//
//  Created by Stuckinaboot on 9/9/16.
//  Copyright © 2016 Stuckinaboot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FloorBackendManager.h"
#import "FloorPlanPreRecordingViewController.h"

static const NSString *kSegueToPreRecording = @"HomeToPreRecordingSegue";
@interface ViewController : UIViewController {
    FloorPlanPreRecordingViewController *preRecordingViewController;
}

@property (nonatomic, strong) FloorBackendManager *backendManager;
- (IBAction)goToPreRecording:(id)sender;
@end

