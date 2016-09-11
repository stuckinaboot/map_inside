//
//  FloorPlanRecordingViewController.m
//  MapInside
//
//  Created by Stuckinaboot on 9/10/16.
//  Copyright © 2016 Stuckinaboot. All rights reserved.
//

#import "FloorPlanRecordingViewController.h"

@interface FloorPlanRecordingViewController ()

@end

@implementation FloorPlanRecordingViewController

- (void)setUp {
    backendManager = [[FloorBackendManager alloc] init];
    singleDeviceManager = NULL;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self beginRecording];
}

- (IBAction)markPoint:(id)sender {
    isWalking = !isWalking;
    if (!isWalking) {
        [markPtBtn setTitle:@"Stopped" forState:UIControlStateNormal];
        [backendManager markPoint];
        pulsingHalo.hidden = YES;
    } else {
        [markPtBtn setTitle:@"Walking" forState:UIControlStateNormal];
        pulsingHalo.hidden = NO;
    }
}

- (IBAction)markPlaceOfInterest:(id)sender {
    isWalking = TRUE;
    [self markPoint:sender];
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    UITextField *nameField = [alert addTextField:@"Name..."];
    UITextField *descriptionField = [alert addTextField:@"Description..."];
    
    [alert addButton:@"Cancel" actionBlock:^(void) {
//        [backendManager resumeRecording];
    }];
    [alert addButton:@"Add" actionBlock:^(void) {
        NSString *name = nameField.text;
        NSString *description = descriptionField.text;

        [backendManager markPointOfInterest:name description:description];
//        [backendManager resumeRecording];
    }];
    
//    [backendManager pauseRecording];
    
    [alert showInfo:self title:@"Point of Interest" subTitle:@"Add a point of interest" closeButtonTitle:NULL duration:0];
}

- (IBAction)done:(id)sender {
//    [self stopRecording];
}

- (void)beginRecording {
    pulsingHalo = [PulsingHaloLayer layer];
    
    [pulsingHaloContainer.layer addSublayer:pulsingHalo];
    
    pulsingHalo.position = CGPointMake(pulsingHaloContainer.frame.size.width / 2, pulsingHaloContainer.frame.size.height / 2);
    pulsingHalo.radius = pulsingHaloContainer.frame.size.width / 3;
    pulsingHalo.pulseInterval = 0.1f;
    pulsingHalo.haloLayerNumber = 10;
    
    fullOutput = [[NSMutableString alloc] init];
    
    isWalking = TRUE;
    [self performSelector:@selector(beginRecordingOnBackend) withObject:nil afterDelay:1.5f];
}

- (void)beginRecordingOnBackend {
    [pulsingHalo start];
    
    if (singleDeviceManager) {
        [singleDeviceManager setUpdateHandler:^(NSData *data, NSError *error) {
            if (data && isWalking) {
                NSString *readableStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                double compassDirection = [backendManager getCompassDirection];
                
                NSString *travelStr = [NSString stringWithFormat:@"%@, %.02f", readableStr, compassDirection];
                
                //Call Fischer's view with the travelStr
                [fullOutput appendFormat:@"%@\n", travelStr];
            }
        }];
    } else {
        updateTimer = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(updateRecording) userInfo:nil repeats:YES];
    }
    
    [backendManager startRecordingPath];
    [self markPoint:nil];
}

- (void)updateRecording {
    if (isWalking) {
        NSString *travelStr = [backendManager markPoint];
        
        //Call Fischer's view with the travelStr
        [fullOutput appendFormat:@"%@\n", travelStr];
    }
}

- (NSString*)stopRecording {
    if (updateTimer) {
        [updateTimer invalidate];
        updateTimer = nil;
        
        [self markPoint:nil];
    }
    [backendManager stopRecordingPath];
//    NSArray *path = [backendManager stopRecordingPath];
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:path options:0 error:nil];
//    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return fullOutput;
}

- (void)setVelocity:(float)vel {
    [backendManager setVelocity:vel];
}

- (void)setBluetoothDeviceManager:(LGSingleDeviceManager*)device {
    singleDeviceManager = device;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kSegueToPostRecording]) {
        NSString *jsonRep = [self stopRecording];
        FloorPlanPostRecordingViewController *vc = (FloorPlanPostRecordingViewController*)segue.destinationViewController;
        [vc setFloorPlanFullOutput:fullOutput];
    }
}

@end
