//
//  FloorPlanRenderView.m
//  MapInside
//
//  Created by Stuckinaboot on 9/10/16.
//  Copyright © 2016 Stuckinaboot. All rights reserved.
//

#import "FloorPlanRenderView.h"

@implementation FloorPlanRenderView

- (void)renderFloorPlan:(NSString*)jsonRepresentation {
    self.layer.borderWidth = 2.0f;

    NSArray *json = [NSJSONSerialization JSONObjectWithData:[jsonRepresentation dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    UIGraphicsBeginImageContext(self.frame.size);
    [self.image drawInRect:self.frame];
    CGContextRef currentContext = UIGraphicsGetCurrentContext();

    /* Set the width for the line */
    CGContextSetLineWidth(currentContext,4.0f);
    
    CGPoint startPt, endPt = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    float startAngle = -1;
    for (int i = 0; i < [json count]; i++) {
        id obj = json[i];
        if ([obj isKindOfClass:[NSArray class]]) {
            NSArray *info = obj;
            float distance = [info[0] floatValue];
            float angle = [info[1] floatValue];
            if (startAngle == -1)
                startAngle = angle;
            angle = angle -startAngle - 90;
            if (angle < 0)
                angle += 360;
            
            float angleInRadians = DEGREES_TO_RADIANS(angle);
            float deltaX = distance * cosf(angleInRadians);
            float deltaY = distance * sinf(angleInRadians);
            
            startPt = endPt;
            
            float newX = endPt.x + deltaX;
            float newY = (endPt.y + deltaY);
            
            endPt = CGPointMake(newX, newY);
            
            CGContextSetLineCap(currentContext, kCGLineCapRound);
            /* Start the line at this point */
            CGContextMoveToPoint(currentContext,startPt.x, startPt.y);
            /* And end it at this point */
            CGContextAddLineToPoint(currentContext,endPt.x, endPt.y);
        } else {
            CGRect containingRect = CGRectMake(endPt.x - 5, endPt.y - 5, 10, 10);
            CGContextSetStrokeColorWithColor(currentContext, [UIColor redColor].CGColor);
            CGContextAddEllipseInRect(currentContext, containingRect);
        }
    }
    /* Use the context's current color to draw the line */
    CGContextStrokePath(currentContext);
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    UIGraphicsBeginImageContext(imgView.frame.size);
//    [imgView.image drawInRect:imgView.frame];
//    CGContextRef currentContext = UIGraphicsGetCurrentContext();
//    
//    for (int i = ;)
//    /* Set the width for the line */
//    CGContextSetLineWidth(currentContext,5.0f);
//    /* Start the line at this point */
//    CGContextMoveToPoint(currentContext,50.0f, 10.0f);
//    /* And end it at this point */
//    CGContextAddLineToPoint(currentContext,100.0f, 200.0f);
//    /* Use the context's current color to draw the line */
//    CGContextStrokePath(currentContext);
//}


@end
