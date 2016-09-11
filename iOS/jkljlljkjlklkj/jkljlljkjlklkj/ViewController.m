//
//  ViewController.m
//  jkljlljkjlklkj
//
//  Created by Stuckinaboot on 9/11/16.
//  Copyright © 2016 Stuckinaboot. All rights reserved.
//

#import "ViewController.h"

#import "LGBluetooth.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)testPressed:(id)sender {
    
    NSString *serviceID = @"6e400001-b5a3-f393-e0a9-e50e24dcca9e";
    NSString *characID = @"6e400003-b5a3-f393-e0a9-e50e24dcca9e";
    NSString *deviceID = @"Adafruit Bluefruit LE";
    
    LGSingleDeviceManager *manager = [[LGSingleDeviceManager alloc] init];
    [manager searchForDevice:deviceID completion:^(BOOL deviceFound) {
        if (deviceFound) {
            [manager subscribeToNotificationsForService:serviceID characteristic:characID onUpdate:^(NSData *data, NSError *error) {
                if (error) {
                    NSLog(@"%@", [error description]);
                } else {
                    NSString *dataContents = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                }
            }];
        }
    }];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
