//
//  SPLBannerViewController.h
//  TalkTimer
//
//  Created by Shannon on 12/24/12.
//  Copyright (c) 2012 Shannon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iAd/ADBannerView.h"
@interface SPLBannerViewController : NSObject<ADBannerViewDelegate,UIGestureRecognizerDelegate>
@property (weak, nonatomic)  ADBannerView *adBanner;
@property (weak, nonatomic)  UIView *MyBannerView;
@property (strong, nonatomic)  UIImageView *imageView;
-(instancetype)initWithBanner:(ADBannerView*)iAdbannerView myBannerView:(UIView*)view parentView:(UIView*)parentView NS_DESIGNATED_INITIALIZER;
-(void)handleTap:(UITapGestureRecognizer *)sender;
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch;
@end
