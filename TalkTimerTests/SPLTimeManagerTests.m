//
//  SPLTimeManagerTests.m
//  TalkTimer
//
//  Created by Shannon on 12/17/12.
//  Copyright (c) 2012 Shannon. All rights reserved.
//

#import "SPLTimeManagerTests.h"
#import "SPLTimeManager.h"
@implementation SPLTimeManagerTests
SPLTimeManager *timeManager;
- (void)setUp
{
    [super setUp];
       
}

- (void)tearDown
{
    // Tear-down code here.
    [super tearDown];
       
}


-(void)UpdateUi
{
            NSLog(@"AbsoluteTime: %f", CFAbsoluteTimeGetCurrent());

}

-(void)testTimerElapsed
{
    timeManager = [[SPLTimeManager alloc]init];
    timeManager.delegate = self;
    [timeManager Start];
   
    //Check the time
    [timeManager.Timer fire];
    //Sleep 1 second
     double elapseWait = 1;
    sleep(elapseWait);
    //Check the elapsed time
    [timeManager.Timer fire];
    double elapsed =  [timeManager ElapsedTime];
    
    NSLog(@"Elapsed: %f",elapsed);

    NSLog(@"elapsedWait: %f  - elapsed:%f", elapseWait, elapsed);
    
  //  Test whether the elapsed time is close the the elapsed waith time.
    STAssertEqualsWithAccuracy(elapseWait,elapsed,.01,@"Elapsed is greater than expected");
    //Elapsed, Current, Start, Pause, Start, Cancel
    [timeManager Cancel];

    
}



@end
