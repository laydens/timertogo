//
//  SPLTimeManager.h
//  TalkTimer
//
//  Created by Shannon on 12/16/12.
//  Copyright (c) 2012 Shannon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPLTimerClient.h"
@interface SPLTimeManager : NSObject 
-(void)Start;
-(void)Pause;
-(void)Resume;
-(void)Cancel;
@property double ElapsedTime;
@property bool isPaused;
@property double StartTime;
@property double PausedTime;
@property id <SPLTimerClient> delegate;
@property double PausedDuration;
@property double TargetEndTime;
@property NSTimer *Timer;


//@property double CurrentRemaining;
@property double CurrentTime;

@end
