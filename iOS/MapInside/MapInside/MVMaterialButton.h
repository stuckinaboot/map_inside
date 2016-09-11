//
//  MVMaterialButton.h
//  MVMaterialViewDemo
//
//  Created by indianic on 21/05/15.
//  Copyright (c) 2015 MV. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMVMaterialButtonCornerRadius 3
#define kMVMaterialCircleAlpha .4f

@interface MVMaterialButton : UIButton{
    CAShapeLayer *aMaterialLayer;
}

@property(nonatomic,strong)UIColor *overlayColor;

@end
