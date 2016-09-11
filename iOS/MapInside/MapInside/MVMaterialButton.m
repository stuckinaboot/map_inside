//
//  MVMaterialButton.m
//  MVMaterialViewDemo
//
//  Created by indianic on 21/05/15.
//  Copyright (c) 2015 MV. All rights reserved.
//

#import "MVMaterialButton.h"

@implementation MVMaterialButton

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setClipsToBounds:YES];
        self.layer.cornerRadius = kMVMaterialButtonCornerRadius;
    }
    return self;
}

- (void)awakeFromNib {
    [self setClipsToBounds:YES];
    self.layer.cornerRadius = kMVMaterialButtonCornerRadius;
}

#define initialSize 20

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    CALayer *layer = [anim valueForKey:@"animationLayer"];
    if (layer) {
        [layer removeAnimationForKey:@"scale"];
        [layer removeFromSuperlayer];
        layer = nil;
        anim = nil;
    }
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    
    UITouch *aTouch = touch;
    
    CGPoint aPntTapLocation = [aTouch locationInView:self];
    
    CALayer *aLayer = [CALayer layer];
    aLayer.backgroundColor = self.tintColor ? [[self.tintColor colorWithAlphaComponent:kMVMaterialCircleAlpha] CGColor] : [UIColor colorWithWhite:1.0 alpha:kMVMaterialCircleAlpha].CGColor;
    aLayer.frame = CGRectMake(0, 0, initialSize, initialSize);
    aLayer.cornerRadius = initialSize / 2;
    aLayer.masksToBounds = YES;
    aLayer.position = aPntTapLocation;
    [self.layer insertSublayer:aLayer below:self.titleLabel.layer];
    
    // Create a basic animation changing the transform.scale value
    CABasicAnimation *animation =
    [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    // Set the initial and the final values
    float finalScale = 2.5 * MAX(self.frame.size.height, self.frame.size.width) /
    initialSize;
    animation.fromValue = [NSNumber numberWithFloat:1];
    aLayer.transform = CATransform3DMakeScale(finalScale, finalScale, 1);
    // Set duration
    [animation setDuration:0.5f];
    
    // Set animation to be consistent on completion
    [animation setRemovedOnCompletion:NO];
    [animation setFillMode:kCAFillModeForwards];
    
    // Add animation to the view's layer
    
    CABasicAnimation *fade =
    [CABasicAnimation animationWithKeyPath:@"opacity"];
    fade.fromValue = @(1);
    aLayer.opacity = 0;
    fade.duration = 0.5;
    [fade setRemovedOnCompletion:NO];
    [fade setFillMode:kCAFillModeForwards];
    
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.duration = 0.5f;
    animGroup.delegate = self;
    animGroup.animations = [NSArray arrayWithObjects:animation, fade, nil];
    [animGroup setValue:aLayer forKey:@"animationLayer"];
    [aLayer addAnimation:animGroup forKey:@"scale"];
    
    return YES;
}

@end
