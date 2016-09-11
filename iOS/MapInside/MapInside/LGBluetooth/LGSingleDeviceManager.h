//
//  LGSingleDeviceManager.h
//  LGBluetoothExample
//
//  Created by Stuckinaboot on 9/10/16.
//  Copyright © 2016 David Sahakyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGBluetooth.h"

@interface LGSingleDeviceManager : NSObject {
    LGPeripheral *device;
    
    void (^mainUpdateHandler)(NSData *data, NSError *error);
}
- (void)searchForDevice:(NSString*)deviceName
             completion:(void (^_Nonnull)(BOOL deviceFound))completionHandler;
- (void)subscribeToNotificationsForService:(NSString*)serviceName
                            characteristic:(NSString*)characteristicName
                                onUpdate:(void (^_Nonnull)(NSData *data, NSError *error))updateHandler;

- (void)setUpdateHandler:(void (^_Nonnull)(NSData *data, NSError *error))updateHandler;
- (void)disconnect;
@end
