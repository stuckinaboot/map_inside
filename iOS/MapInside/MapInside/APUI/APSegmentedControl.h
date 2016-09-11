//
//  APSegmentedControl.h
//  MapInside
//
//  Created by Stuckinaboot on 9/10/16.
//  Copyright © 2016 Stuckinaboot. All rights reserved.
//

#import <UIKit/UIKit.h>

static const float kDefaultAnimationDuration = 0.4f;
static const int kBorderWidth = 1;

static const float kDefaultHighlightColorComponents[] = {179/255.0f, 217/255.0f, 255/255.0f, 0.5f};

@interface APSegmentedControl : UIView {
    NSArray *segmentBtns;
    UIImageView *selectionHighlightView;
    
    NSInteger selectedBtnIndex;
}
@property (nonatomic) id delegate;
- (void)selectButtonAtIndex:(NSInteger)btnIndex animated:(BOOL)animated;
- (void)setButtonNames:(NSArray*)btnNames;
- (NSString*)selectedButtonName;
@end
@protocol APSegmentedControlDelegate <NSObject>
- (void)segmentedControl:(APSegmentedControl*)segmentedControl buttonSelectedForButtonName:(NSString*)btnName;
@end