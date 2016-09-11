//
//  ViewController.m
//  MapInside
//
//  Created by Stuckinaboot on 9/9/16.
//  Copyright © 2016 Stuckinaboot. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize backendManager;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    preRecordingViewController = [[FloorPlanPreRecordingViewController alloc] init];
}

- (IBAction)goToPreRecording:(id)sender {
    [self presentViewController:preRecordingViewController animated:YES completion:nil];
}

- (IBAction)about:(id)sender {
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    [alert showInfo:self title:@"About" subTitle:@"Developed by\nThe Platypus Project" closeButtonTitle:@"Dismiss" duration:0];
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
