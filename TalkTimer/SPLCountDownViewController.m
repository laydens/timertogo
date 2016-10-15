//
//  SPLCountDownViewController.m
//  TalkTimer
//
//  Created by Shannon on 12/1/12.
//  Copyright (c) 2012 Shannon. All rights reserved.
//

#import "SPLCountDownViewController.h"
#import "SPLSoundPlayer.h"
#import "SPLTimeManager.h"
#import "ProgressIndicator.h"
#import "SPLBannerViewController.h"
@interface SPLCountDownViewController ()
@property double percentRemaining;
@property (weak, nonatomic) IBOutlet UILabel *SecondsTopLabel;
@property (weak, nonatomic) IBOutlet UILabel *MinutesTopLabel;
@property (weak, nonatomic) IBOutlet UILabel *HoursTopLabel;
@property (weak, nonatomic) IBOutlet UILabel *MinuteColon;
@property (weak, nonatomic) IBOutlet UILabel *HourColon;
@property (weak, nonatomic) IBOutlet UILabel *MilisecondBottomLabel;
@property (weak, nonatomic) IBOutlet UILabel *DigitsLabelBottom;
@property (weak, nonatomic) IBOutlet UILabel *MilisecondTopLabel;
@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;
@property (weak, nonatomic) IBOutlet UILabel *MilisecondBottom;
@property (weak, nonatomic) IBOutlet UILabel *ElapsedLabel;
@property (weak, nonatomic) IBOutlet UILabel *BackgroundNumbersTopLabel;
@property (strong, nonatomic) NSTimer* timer;
@property (weak, nonatomic) IBOutlet UILabel *RemainingLabel;
@property (weak, nonatomic) IBOutlet UIButton *PauseButton;
@property (weak, nonatomic) IBOutlet UIView *CircleView;

@property SPLTimeManager *timeManager;
@property CFAbsoluteTime startTime;
@property CFAbsoluteTime currentTime;
@property NSString *displayPercentRemaining;
@property ProgressIndicator *progressCircle;
@property BOOL isTimerFinished;
@property BOOL hasFinishedCountdown;
@property SPLBannerViewController *bannerManager;
-(void)playButtonDownSound;
-(void)playButtonUpSound;

- (IBAction)PauseClock:(id)sender;
@property double currentInterval;
@property double currentElapsed;
-(void)SetFonts;
-(void)SetRemainingTimeValues;
-(void)SetElapsedTimeValues;
-(void)UpdateUi;
@property bool isPaused;

@end

@implementation SPLCountDownViewController
@synthesize displayPercentRemaining;
@synthesize hasFinishedCountdown;
@synthesize cancelButton;
@synthesize startInterval;
@synthesize countDownLabel;
@synthesize timer;
@synthesize currentInterval;
@synthesize currentElapsed;
@synthesize isTimerFinished;
@synthesize startTime;
@synthesize currentTime;
@synthesize timeManager;
@synthesize PercentIndicater;
@synthesize percentRemaining;
@synthesize iAdBanner;
@synthesize MyAd;
@synthesize bannerManager;






#pragma mark -
#pragma mark Banner Methods
-(void)bannerViewDidLoadAd:(ADBannerView *)banner
{


}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{


}


#pragma mark-
#pragma mark events and callbacks


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self SetFonts];
   //  self.isPaused = false;
    self.progressCircle = [[ProgressIndicator alloc] initWithFrame:self.CircleView.frame];
    self.progressCircle.center = self.view.center;
   //[self.progressCircle setBackgroundColor:[UIColor greenColor]];
   // [self.CircleView setBackgroundColor:[UIColor yellowColor]];
    [self.view addSubview:self.progressCircle];
    self.DigitsLabelBottom.hidden = true;
    self.MilisecondBottomLabel.hidden = true;
    self.ElapsedLabel.hidden = true;
    
    
  //  self.bannerManager = [[SPLBannerViewController alloc] initWithBanner:self.iAdBanner myBannerView:self.MyAd parentView:self.parentView];
    
//    self.iAdBanner.delegate = self.bannerManager;
    // do something you want to measure

	// Do any additional setup after loading the view.
}

-(void)UpdateUi
{
   // NSLog(@"%f",self.currentInterval);
    [self Tick];
}

-(void)Tick
{
     if(self.currentInterval > 0)
    {
        self.currentInterval = self.startInterval - (timeManager.CurrentTime-timeManager.StartTime);
        [self SetRemainingTimeValues];
    }else
    {
        self.currentInterval = 0;
        [self SetRemainingTimeValues];
        [self notifyUserOfTimerComplete];
        [self SetElapsedTimeValues];
        if(!self.hasFinishedCountdown)
        {
            [self updateElapsedFontSizes];
            self.hasFinishedCountdown = YES;
        }
    }
    
    [self updatePercentFontSizes];
    self.percentRemaining = self.currentElapsed/self.startInterval*100;
    self.displayPercentRemaining = [NSString stringWithFormat:@"%.0f%%",self.percentRemaining];
    
    if(![self.PercentAmount.text isEqualToString:self.displayPercentRemaining])
    {
        self.PercentAmount.text = self.displayPercentRemaining;
        }
    
    int percentPrecision = self.percentRemaining*100;
   
    if((percentPrecision%10) == 0)
    {
        self.progressCircle.percentComplete = self.percentRemaining;

        [self.progressCircle  setNeedsDisplay];
    }
    
    //Elapsed
    self.currentElapsed = timeManager.CurrentTime - timeManager.StartTime;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}


- (void)viewDidUnload
{
    [self setCountDownLabel:nil];
    [self setCancelButton:nil];
    [self setRemainingLabel:nil];
    [self setMilisecondTopLabel:nil];
    [self setMilisecondBottom:nil];
    [self setDigitsLabelBottom:nil];
    [self setMilisecondBottomLabel:nil];
    [self setPauseButton:nil];
    [self setBackgroundNumbersTopLabel:nil];
    [self setHourColon:nil];
    [self setMinuteColon:nil];
    [self setHoursTopLabel:nil];
    [self setMinutesTopLabel:nil];
    [self setSecondsTopLabel:nil];
    [self setPercentIndicater:nil];
    [self setPercentAmount:nil];
    [self setElapsedLabel:nil];
    [self setMyAd:nil];
    [self setParentView:nil];
    [super viewDidUnload];
   }

#pragma mark-
#pragma mark User Actions
- (IBAction)cancel:(id)sender {
    
    
    [timer invalidate];
    timer = nil;
    [self playButtonUpSound];
    [self.timeManager Cancel];
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
    
}

- (IBAction)ClickDown:(id)sender {
    [self playButtonDownSound];
    
}


- (IBAction)PauseClock:(UIButton*)sender {
    
    [self.timer invalidate];
    self.timer  = nil;
    
    [self playButtonUpSound];
    
    if (!self.isPaused) {
        [timeManager Pause];
        [sender setImage:[UIImage imageNamed:@"resume.png"]
                forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"resumeOn.png"]
                forState:UIControlStateHighlighted];
        self.isPaused = YES;
        
    }else {
        [sender setImage:[UIImage imageNamed:@"Pause.png"]
                forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"PauseOn.png"]
                forState:UIControlStateHighlighted];
        self.isPaused = NO;
        [timeManager Resume];
    }
}


#pragma mark-

-(void)notifyUserOfTimerComplete
{
    if(!isTimerFinished)
    {
    SPLSoundPlayer *player = [[SPLSoundPlayer alloc] initWithPath:@"endingBell.aif"];
       [player vibrate];
       [player vibrate];     
       [player play];
        self.isTimerFinished = true;
        
    }
}

-(void)adjustUiAfterEndTimer
{


}



-(void)playButtonDownSound
{
    
    SPLSoundPlayer* player = [[SPLSoundPlayer alloc] initWithPath:@"downclick.aif"];
    [player play];
}

-(void)playButtonUpSound
{
    SPLSoundPlayer* player = [[SPLSoundPlayer alloc] initWithPath:@"upclick.aif"];
    [player play];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}


-(void)startTimer:(NSTimeInterval)interval
{
    
    // startTime = CFAbsoluteTimeGetCurrent();
    timeManager = [[SPLTimeManager alloc]init];
    timeManager.delegate = self;
    [timeManager Start];
    self.startInterval = self.currentInterval = interval;
}



-(void)SetFonts
{
   
    UIFont *bigFont = [UIFont fontWithName:@"Digital-7" size:75];
    UIFont *mediumFont = [UIFont fontWithName:@"Digital-7" size:30];
    UIFont *smallFont = [UIFont fontWithName:@"Digital-7" size:20];
    UIFont *percentFont = [UIFont fontWithName:@"Digital-7" size:60];
    
    self.PercentAmount.font = percentFont;
    self.MilisecondTopLabel.font = mediumFont;
    self.countDownLabel.font = bigFont;
    self.BackgroundNumbersTopLabel.font = bigFont;
    self.MinutesTopLabel.font = bigFont;
    self.MinuteColon.font = bigFont;
    self.SecondsTopLabel.font = bigFont;
    self.HoursTopLabel.font = bigFont;
    self.HourColon.font = bigFont;
    self.DigitsLabelBottom.font = mediumFont;
    self.MilisecondBottomLabel.font = smallFont;
}



-(void)updatePercentFontSizes;
{
   
    if(self.percentRemaining > 999 && self.percentRemaining < 9999)
    {
        UIFont *percentFont = [UIFont fontWithName:@"Apple LiGothic" size:45];
        self.PercentAmount.font = percentFont;
    }
    else if(self.percentRemaining > 9999)
    {
        UIFont *percentFont = [UIFont fontWithName:@"Apple LiGothic" size:20];
        self.PercentAmount.font = percentFont;
    }
 
}

-(void)updateElapsedFontSizes;
{
  /*  CGFloat elx = self.ElapsedLabel.center.x;
    CGFloat ely = self.ElapsedLabel.center.y-25;
    
    CGPoint elapsedCenter = CGPointMake(elx, ely);
    self.ElapsedLabel.center = elapsedCenter;
    
    
    //main digist bottom
    CGFloat dlx = self.DigitsLabelBottom.center.x+100;
    CGFloat dly = self.DigitsLabelBottom.center.y-20;
    CGPoint digitsBottomCenter = CGPointMake(dlx, dly);
    self.DigitsLabelBottom.center = digitsBottomCenter;
    
    
    //seconds top
    CGFloat dtx = self.SecondsTopLabel.center.x-205;
    CGFloat dty = self.SecondsTopLabel.center.y-15;
    CGPoint digitsTop = CGPointMake(dtx, dty);
    self.SecondsTopLabel.center = digitsTop;
    
    //milliseconds top
    CGFloat mtx = self.MilisecondTopLabel.center.x-205;
    CGFloat mty = self.MilisecondTopLabel.center.y-30;
    CGPoint militopCenter = CGPointMake(mtx, mty);
    self.MilisecondTopLabel.center = militopCenter;
   */
    
    self.DigitsLabelBottom.font = [UIFont fontWithName:@"Digital-7" size:60];
   
    self.SecondsTopLabel.hidden = YES;
    self.MilisecondTopLabel.hidden = YES;
  //  self.MilisecondBottom.font = [UIFont fontWithName:@"Digital-7" size:30];
    self.SecondsTopLabel.font =[UIFont fontWithName:@"Digital-7" size:30];
    self.MilisecondTopLabel.font = [UIFont fontWithName:@"Digital-7" size:18];


}

-(void)SetElapsedTimeValues
{
    if(self.currentInterval == 0)
    {
        self.DigitsLabelBottom.hidden = false;
        self.MilisecondBottomLabel.hidden = false;
        self.ElapsedLabel.hidden = false;
    }
    
    int elapsedMilliseconds = self.currentElapsed*1000;
    int elapsedSeconds = elapsedMilliseconds/1000;
    int elapsedMinutes = elapsedSeconds/60;
    int elapsedHours = elapsedMinutes/60;
    elapsedSeconds -= elapsedMinutes * 60;
    elapsedMinutes -= elapsedHours * 60;
    int displayMilliseconds = (elapsedMilliseconds%1000);
    self.PercentAmount.text = [NSString stringWithFormat:@"%d%%",elapsedSeconds];
    if(self.currentInterval == 0)
    {
    self.MilisecondBottomLabel.text = [NSString stringWithFormat:@"%03d",displayMilliseconds];
    }
    else
    {
    self.MilisecondBottomLabel.text = @"";
    }
    
    NSString *hoursString = elapsedHours > 0 ? [NSString stringWithFormat:@"%02d:",elapsedHours]: @"00:";
    NSString *minutesString = elapsedMinutes + elapsedHours > 0 ? [NSString stringWithFormat:@"%02d:",elapsedMinutes]: @"00:";
    NSString *secondsString =[NSString stringWithFormat:@"%02d",elapsedSeconds];
    
    self.DigitsLabelBottom.text =[NSString stringWithFormat:@"%@%@%@",hoursString,minutesString,secondsString];

}


-(void)SetRemainingTimeValues
{

    int milliseconds = self.currentInterval*1000;
   // NSLog(@"milliseconds: %d",(milliseconds%1000)/100);
    int seconds = milliseconds/1000;
    int minutes = seconds / 60;
    int hours = minutes / 60;
    int displayMilliseconds = (milliseconds%1000);
    seconds -= minutes * 60;
    minutes -= hours * 60;
    
    NSString *hoursDisplay = hours > 0 ? [NSString stringWithFormat:@"%02d",hours] :@"";
    NSString *minutesDisplay =  minutes + hours > 0?[NSString stringWithFormat:@"%02d",minutes]:@"";
    NSString *secondsDisplay = [NSString stringWithFormat:@"%02d",seconds];
    self.MilisecondTopLabel.text = [NSString stringWithFormat:@"%03d",displayMilliseconds];
   
    self.HoursTopLabel.text = hoursDisplay;
    self.MinutesTopLabel.text = minutesDisplay;
    self.SecondsTopLabel.text = secondsDisplay;
    self.HourColon.hidden = true;
    self.MinuteColon.hidden = true;
    
    if(hours > 0)
    {
        self.HourColon.hidden = false;
        self.MinuteColon.hidden = false;
    }else if(minutes + hours > 0)
    {
        self.MinuteColon.hidden = false;
    }
    
}






/*- (NSString*)getIntervalDisplayString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"mm:ss:SSS"];
  //  NSTimeInterval interval = startInterval-1;
    NSString *display = @"test2";
    return display;
}*/

@end
