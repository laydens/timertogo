//
//  SPLTimeManager.m
//  TalkTimer
//
//  Created by Shannon on 12/16/12.
//  Copyright (c) 2012 Shannon. All rights reserved.
//

#import "SPLTimeManager.h"
@interface SPLTimeManager()

@end


@implementation SPLTimeManager
@synthesize ElapsedTime;
@synthesize Timer;
@synthesize CurrentTime;
@synthesize StartTime;
@synthesize delegate;
@synthesize PausedTime;
@synthesize PausedDuration;
@synthesize TargetEndTime;
- (instancetype)init

{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)Start
{
    self.StartTime = CFAbsoluteTimeGetCurrent();
    self.PausedDuration = 0;
    if (Timer == nil)
    {
        Timer = [NSTimer scheduledTimerWithTimeInterval:.01
                                                 target:self
                                               selector:@selector(Tick)
                                               userInfo:nil repeats:YES];
    }
}

-(void)Tick
{
    if(!self.isPaused)
    {
    self.CurrentTime = CFAbsoluteTimeGetCurrent() - self.PausedDuration;
     //Elapsed
    self.ElapsedTime = self.CurrentTime - self.StartTime;
    [delegate UpdateUi];
    }
}

-(void)Cancel
{
    [self.Timer invalidate];
    self.Timer = nil;
}


-(void)Pause
{
    //Markt the time that pause started
    self.PausedTime = self.CurrentTime;
    self.isPaused = YES;
    
}
-(void)Resume
{
    self.isPaused = NO;
    double resumeTime = CFAbsoluteTimeGetCurrent();
    NSLog(@"resume time:%f", resumeTime);
    self.PausedDuration = (resumeTime - self.PausedTime);
    //Adjust CurrentTime by subtracting the time that has beed paused.
    self.CurrentTime = self.CurrentTime - self.PausedDuration;
    NSLog(@"currentTime minus paused time:@%f",self.CurrentTime);
    NSLog(@"paused time:@%f",self.PausedTime);
    
}

- (void)scheduleAlarmForDate:(NSDate*)theDate
{
    UIApplication* app = [UIApplication sharedApplication];
    NSArray*    oldNotifications = app.scheduledLocalNotifications;
    
    // Clear out the old notification before scheduling a new one.
    if (oldNotifications.count > 0)
        [app cancelAllLocalNotifications];
    
    // Create a new notification.
    UILocalNotification* alarm = [[UILocalNotification alloc] init];
    if (alarm)
    {
        alarm.fireDate = theDate;
        alarm.timeZone = [NSTimeZone defaultTimeZone];
        alarm.repeatInterval = 0;
        alarm.soundName = @"endingBell.aif";
        alarm.alertBody = @"Timer finished";
        
        [app scheduleLocalNotification:alarm];
    }
}




@end
