//
//  FloorPlanDisplayView.m
//  MapInside
//
//  Created by Stuckinaboot on 9/11/16.
//  Copyright © 2016 Stuckinaboot. All rights reserved.
//

#import "FloorPlanDisplayView.h"

@implementation FloorPlanDisplayView

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.layer.borderWidth = 1.0f;
    }
    return self;
}

- (void)setUp {
    prevPt = CGPointMake(self.frame.size.width / 2, self.frame.size.height);
    startAngle = -1;
}

- (void)updateDrawingForTravelStr:(NSString*)travelStr {
    //Call Fischer's view with the travelStr
    NSArray *comps = [travelStr componentsSeparatedByString:@","];
    
//    float compL = [[[comps objectAtIndex:0] substringFromIndex:[[comps objectAtIndex:0] rangeOfString:@" "options:NSBackwardsSearch].location + 1] floatValue];
//    
////    float compR = [[[comps objectAtIndex:1] substringFromIndex:[[comps objectAtIndex:1] rangeOfString:@" " options:NSBackwardsSearch].location + 1] floatValue];
    
    NSString *angleStr = [comps objectAtIndex:[comps count] - 1];
    float angle = [[angleStr substringFromIndex:[angleStr rangeOfString:@" " options:NSBackwardsSearch].location + 1] floatValue];
    
    if (startAngle == -1) {
        startAngle = angle + 90.0f;
        if (startAngle < 0)
            startAngle += 360.0f;
        if (startAngle > 360)
            startAngle -= 360.0f;
//        else if (startAngle > 360.0f) {
//            startAngle -= 360.0f;
//        }
    }
    angle -= startAngle;
    if (angle < 0)
        angle += 360.0f;
    if (angle > 360)
        angle -= 360.0f;
    
    float angleInRadians = DEGREES_TO_RADIANS(angle);
    
    CGPoint delta = CGPointMake(5.0f*cosf(angleInRadians), 5.0f*sinf(angleInRadians));
//    float deltaX = 5.0f*cosf(DEGREES_TO_RADIANS(angle));
//    float deltaY = 5.0f*sinf(DEGREES_TO_RADIANS(angle));
    
    CGPoint newPt = CGPointMake(prevPt.x + delta.x, prevPt.y + delta.y);

//    if (compL >= 0.0) {
//        float ltX = newPt.x - compL;
        [self drawDotWithRadius:1.0f atX:newPt.x atY:newPt.y];
//    }
//    if (compR >= 0.0) {
//        float rtX = newPt.x + compR;
//        [self drawDotWithRadius:1.0f atX:rtX atY:newPt.y];
//    }
    prevPt = newPt;
}


#pragma mark - Drawing
- (void)drawDotWithRadius:(float)radius atX:(float)xcor atY:(float)ycor {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [[UIColor blueColor] CGColor];
    shapeLayer.fillColor = [[UIColor blueColor] CGColor];
    shapeLayer.lineWidth = 2.0;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(xcor, ycor, radius, radius)];
    shapeLayer.path = [path CGPath];
    
    [self.layer addSublayer:shapeLayer];
}

- (void)drawLineFromX:(float)xcor1 Y:(float)ycor1 toX:(float)xcor2 Y: (float)ycor2 {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [[UIColor blackColor] CGColor];
    shapeLayer.fillColor = [[UIColor blackColor] CGColor];
    shapeLayer.lineWidth = 1.0;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(xcor1, ycor1)];
    [path addLineToPoint:CGPointMake(xcor2, ycor2)];
    
    shapeLayer.path = [path CGPath];
    [self.layer addSublayer:shapeLayer];
}

@end
