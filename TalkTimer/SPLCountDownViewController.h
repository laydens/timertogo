//
//  SPLCountDownViewController.h
//  TalkTimer
//
//  Created by Shannon on 12/1/12.
//  Copyright (c) 2012 Shannon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPLTimerClient.h"
#import "iAd/ADBannerView.h"

@interface SPLCountDownViewController : UIViewController<SPLTimerClient,ADBannerViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property double startInterval;
- (IBAction)cancel:(id)sender;
-(void)startTimer:(NSTimeInterval)interval;
- (IBAction)ClickDown:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *PercentAmount;
@property (weak, nonatomic) IBOutlet ADBannerView *iAdBanner;
@property (weak, nonatomic) IBOutlet UIView *PercentIndicater;
@property (weak, nonatomic) IBOutlet UIView *MyAd;
@property (strong, nonatomic) IBOutlet UIView *parentView;



@end
