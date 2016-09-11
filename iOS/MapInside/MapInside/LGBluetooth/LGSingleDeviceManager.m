//
//  LGSingleDeviceManager.m
//  LGBluetoothExample
//
//  Created by Stuckinaboot on 9/10/16.
//  Copyright © 2016 David Sahakyan. All rights reserved.
//

#import "LGSingleDeviceManager.h"

@implementation LGSingleDeviceManager

- (id)init {
    if (self = [super init]) {
        [LGCentralManager sharedInstance];
    }
    return self;
}

- (void)searchForDevice:(NSString*)deviceName
             completion:(void (^_Nonnull)(BOOL deviceFound))completionHandler {
    [[LGCentralManager sharedInstance] scanForPeripheralsByInterval:4
                                                         completion:^(NSArray *peripherals)
     {
         device = NULL;
         if (peripherals.count) {
             for (LGPeripheral *peripheral in peripherals) {
                 if ([peripheral.advertisingData[@"kCBAdvDataLocalName"] isEqualToString:deviceName]) {
                     device = peripheral;
                     break;
                 }
             }
         }

         completionHandler(device != NULL);
     }];
}

- (void)subscribeToNotificationsForService:(NSString*)serviceName
                            characteristic:(NSString*)characteristicName
                                  onUpdate:(void (^ _Nonnull)(NSData *, NSError *))updateHandler {
    mainUpdateHandler = updateHandler;
    
    [device connectWithCompletion:^(NSError *error) {
        [device discoverServicesWithCompletion:^(NSArray *services, NSError *error) {
            for (LGService *service in services) {
                if ([service.UUIDString isEqualToString:serviceName]) {
                    [service discoverCharacteristicsWithCompletion:^(NSArray *characteristics, NSError *error) {
                        for (LGCharacteristic *charact in characteristics) {
                            if ([charact.UUIDString isEqualToString:characteristicName]) {
                                [charact setNotifyValue:YES completion:^(NSError *error) {
                                    if (mainUpdateHandler)
                                        mainUpdateHandler(NULL, error);
                                } onUpdate:^(NSData *data, NSError *error) {
                                    if (mainUpdateHandler)
                                        mainUpdateHandler(data, error);
                                }];
                                break;
                            }
                        }
                    }];
                }
            }
        }];
    }];
}

- (void)setUpdateHandler:(void (^_Nonnull)(NSData *data, NSError *error))updateHandler {
    mainUpdateHandler = updateHandler;
}

- (void)disconnect {
    [device disconnectWithCompletion:nil];
}

@end
