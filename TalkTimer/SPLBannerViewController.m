//
//  SPLBannerViewController.m
//  TalkTimer
//
//  Created by Shannon on 12/24/12.
//  Copyright (c) 2012 Shannon. All rights reserved.
//

#import "SPLBannerViewController.h"

@interface SPLBannerViewController ()
@property CGPoint visibleCenter;
@property CGPoint invisibleCenter;
@property UIGestureRecognizer *gestureRecognizer;
@end

@implementation SPLBannerViewController
@synthesize imageView;
@synthesize adBanner;
@synthesize MyBannerView;
@synthesize gestureRecognizer;

#pragma mark-
#pragma mark view methods

const NSString *paidAppID = @"timer-to-go/id590503269?mt=8";
//https://itunes.apple.com/us/app/timer-to-go/id590503269

-(instancetype)initWithBanner:(ADBannerView*)iAdbannerView myBannerView:(UIView*)view parentView:(UIView*)parentView
{
    self = [super init];
    if (self) {
        self.visibleCenter = CGPointMake(iAdbannerView.center.x, iAdbannerView.center.y);
        self.invisibleCenter = CGPointMake(self.visibleCenter.x,self.visibleCenter.y +100);
        
#ifdef FULL_VERSION
        iAdbannerView.center = self.invisibleCenter;
        self.MyBannerView.center = self.invisibleCenter;
        iAdbannerView.hidden = YES;
        self.MyBannerView.hidden = YES;
        iAdbannerView.delegate = nil;
       
        
#endif
#ifdef FREE_VERSION
        
        [parentView bringSubviewToFront:iAdbannerView];
        self.adBanner = iAdbannerView;
        
        
        self.MyBannerView = view;
        self.MyBannerView.center = self.visibleCenter;
        [self showMyBanner];
        self.gestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
        [self.gestureRecognizer setDelegate:self];
        [self.MyBannerView addGestureRecognizer:self.gestureRecognizer];
        
#endif
        
    }
    return self;
}

-(void)handleTap:(UITapGestureRecognizer *)sender
{
    NSLog(@"I tapped that! %d", sender.numberOfTouches);
    NSLocale *currentLocale = [NSLocale currentLocale];
    NSString *countryCode = [[currentLocale objectForKey:NSLocaleCountryCode] lowercaseString];
    NSString *appUrl =  [NSString stringWithFormat:@"itms://itunes.apple.com/%@/app/%@",countryCode,paidAppID]; //@"itms://itunes.apple.com/us/app/timer-to-go/id590503269?mt=8";
    NSString *escaped = [appUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"URL: %@", escaped);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:escaped]];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    return YES;
}


#pragma mark-
#pragma mark banner methods

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    
    [self showMyBanner];
    

}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    //[banner.superview bringSubviewToFront:banner];
    banner.center = self.visibleCenter;
    self.MyBannerView.center = self.invisibleCenter;
    self.MyBannerView.hidden = YES;
    [self.MyBannerView setNeedsDisplay];
}

-(void)showMyBanner
{
    self.MyBannerView.hidden = NO;
    UIImage *myBannerImage = [UIImage imageNamed:@"TTBanner.png"];
    imageView = [[UIImageView alloc] initWithImage:myBannerImage];
    [self.MyBannerView addSubview:imageView];
    self.MyBannerView.center = self.visibleCenter;
    self.adBanner.center = self.invisibleCenter;
    [self.adBanner setNeedsDisplay];
    [self.MyBannerView setNeedsDisplay];
    //[imageView setNeedsDisplay];
    
    
}


#pragma -mark


@end
