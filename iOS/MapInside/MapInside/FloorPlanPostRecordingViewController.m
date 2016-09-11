//
//  FloorPlanPostRecordingViewController.m
//  MapInside
//
//  Created by Stuckinaboot on 9/10/16.
//  Copyright © 2016 Stuckinaboot. All rights reserved.
//

#import "FloorPlanPostRecordingViewController.h"

@interface FloorPlanPostRecordingViewController ()

@end

@implementation FloorPlanPostRecordingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)done:(id)sender {
    [self.view.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)setFloorPlanFullOutput:(NSString *)output {
    floorPlanFullOutput = [output stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    renderedFloorPlan = FALSE;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (!renderedFloorPlan) {
        [floorPlanDisplayView setUp];
        NSArray *components = [floorPlanFullOutput componentsSeparatedByString:@"\n"];
        for (int i = 1; i < [components count]; i++) {
            NSString *travelStr = components[i];
            [floorPlanDisplayView updateDrawingForTravelStr:travelStr];
        }
        renderedFloorPlan = TRUE;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
