//
//  ViewController.m
//  test-data-parser
//
//  Created by Andrew Fischer on 9/10/16.
//  Copyright © 2016 Andrew Fischer. All rights reserved.
//

#import "ViewController.h"
#import "DataParser.h"


@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect screen = [[UIScreen mainScreen] bounds];
    float scrWidth = screen.size.width;
    float scrHeight = screen.size.height;
    
    NSArray *data = [DataParser rawDataFromFile];
    float currentFoot = 1.0;
    
    for (NSString *tick in data) {
        // If it is a data stream, we're going to want to run this every time
        // we recieve new data.
        NSArray *comps = [tick componentsSeparatedByString:@","];
        if ([[comps objectAtIndex:0] floatValue] > 0.0) {
            float ltX = scrWidth/2.0 - [[comps objectAtIndex:0] floatValue];
            [self drawDotWithRadius:1.0 atX:ltX atY:scrHeight - 3*currentFoot];
        }
        if ([[comps objectAtIndex:1] floatValue] > 0.0) {
            float rtX = scrWidth/2.0 + [[comps objectAtIndex:1] floatValue];
            [self drawDotWithRadius:1.0 atX:rtX atY:scrHeight - 3*currentFoot];
        }
        currentFoot++;
    }
    
    [self drawNormalizedLinesWithData:data];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawDotWithRadius:(float)radius atX:(float)xcor atY:(float)ycor {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [[UIColor blueColor] CGColor];
    shapeLayer.fillColor = [[UIColor blueColor] CGColor];
    shapeLayer.lineWidth = 2.0;

    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(xcor, ycor, radius, radius)];
    shapeLayer.path = [path CGPath];

    [self.view.layer addSublayer:shapeLayer];
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
    [self.view.layer addSublayer:shapeLayer];
}

- (void)drawNormalizedLinesWithData:(NSArray *)data {
    NSMutableArray *leftVals = [[NSMutableArray alloc] init];
    NSMutableArray *rightVals = [[NSMutableArray alloc] init];
    
    
    for (NSString *tick in data) {
        NSArray *comps = [tick componentsSeparatedByString:@","];
        [leftVals addObject:[comps objectAtIndex:0]];
        [rightVals addObject:[comps objectAtIndex:1]];
    }
    CGRect bounds = [[UIScreen mainScreen] bounds];
    float center = bounds.size.width/2;
    float topY = bounds.size.height - 3 * [leftVals count];
    
    // okay. Now need to find strings of -1s and split those out
    
    
    NSNumber *ltXAvg = [leftVals valueForKeyPath:@"@avg.self"];
    NSNumber *rtXAvg = [rightVals valueForKeyPath:@"@avg.self"];
    
    [self subArraysFromHallwayData:rightVals];
    
    [self drawLineFromX:center-[ltXAvg floatValue] Y:bounds.size.height toX:center-[ltXAvg floatValue] Y:topY];
    [self drawLineFromX:center+[rtXAvg floatValue] Y:bounds.size.height toX:center+[rtXAvg floatValue] Y:topY];

}

- (NSArray *) subArraysFromHallwayData:(NSArray *) data {
    NSMutableArray *subArrays = [[NSMutableArray alloc] init];
    NSInteger *arrayIndex = 0;
    
    [subArrays addObject:[[NSMutableArray alloc] init]];
    
    for (NSInteger *index=0; index < [data count]; index++) {
        if (([data objectAtIndex:index] == 0 && [data objectAtIndex:index - 1] > 0) ||
            ([data objectAtIndex:index] > 0 && [data objectAtIndex:index - 1] == 0)) {
            NSMutableArray *addTo = [subArrays objectAtIndex:arrayIndex];
            [addTo addObject:[data objectAtIndex:index]];
            arrayIndex++;
            [subArrays addObject:[[NSMutableArray alloc] init]];
            NSLog(@"WOOP SWITACH");
        } else {
            NSMutableArray *addTo = [subArrays objectAtIndex:arrayIndex];
            [addTo addObject:[data objectAtIndex:index]];
        }
    
    }
    return subArrays;
}

@end
