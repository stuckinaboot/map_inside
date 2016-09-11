//
//  APSegmentedControl.m
//  MapInside
//
//  Created by Stuckinaboot on 9/10/16.
//  Copyright © 2016 Stuckinaboot. All rights reserved.
//

#import "APSegmentedControl.h"

@implementation APSegmentedControl

@synthesize delegate;

- (void)setButtonNames:(NSArray*)btnNames {
    NSMutableArray *btns = [NSMutableArray array];
    
    CGRect frame = self.frame;
    CGSize size = frame.size;
    
    CGSize btnSize = CGSizeMake(size.width / [btnNames count], size.height);
    
    self.layer.borderWidth = kBorderWidth;
    self.layer.cornerRadius = 3;
    
    int x = 0;
    for (int i = 0; i < [btnNames count]; i++) {
        NSString* name = btnNames[i];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(x, 0, btnSize.width, btnSize.height)];
        [btn setTitle:name forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        btn.tag = i;
        
        [btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [btns addObject:btn];
        [self addSubview:btn];
        
        x += btnSize.width;
    }
    
    segmentBtns = btns;
    
    selectionHighlightView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, btnSize.width, size.height)];
    selectionHighlightView.backgroundColor = [UIColor colorWithRed:kDefaultHighlightColorComponents[0] green:kDefaultHighlightColorComponents[1] blue:kDefaultHighlightColorComponents[2] alpha:kDefaultHighlightColorComponents[3]];
    [self addSubview:selectionHighlightView];
    
    [self selectButtonAtIndex:0 animated:NO];
}

- (void)selectButtonAtIndex:(NSInteger)btnIndex animated:(BOOL)animated {
    float duration = kDefaultAnimationDuration;
    if (!animated)
        duration = 0;
    [UIView animateWithDuration:duration animations:^{
        selectionHighlightView.center = ((UIButton*)segmentBtns[btnIndex]).center;
    } completion:^(BOOL finished) {
        selectedBtnIndex = btnIndex;
    }];
}

- (NSString*)selectedButtonName {
    return [((UIButton*)segmentBtns[selectedBtnIndex]) currentTitle];
}

- (IBAction)btnPressed:(id)sender {
    UIButton *btn = sender;
    [self selectButtonAtIndex:btn.tag animated:YES];
    [delegate segmentedControl:self buttonSelectedForButtonName:btn.currentTitle];
}

@end
