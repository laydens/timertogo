//
//  TalkTimerTests.m
//  TalkTimerTests
//
//  Created by Shannon on 11/30/12.
//  Copyright (c) 2012 Shannon. All rights reserved.
//

#import "TalkTimerTests.h"
#import "SPLSoundPlayer.h"
#import "SPLTimeManager.h"

@implementation TalkTimerTests
SPLSoundPlayer *player;

- (void)setUp
{
    [super setUp];
   

   }

- (void)tearDown
{
    // Tear-down code here.
    [super tearDown];
   
}

- (void)testSoundDownClick
{
    player = [[SPLSoundPlayer alloc] initWithPath:@"downclick.aif"];
    NSBundle* bundle = [NSBundle mainBundle];
    player.fullpath = [bundle pathForResource:@"downclick.aif" ofType:@"aif"];
    [player play];
   // STFail(@"Unit tests are not implemented yet in TalkTimerTests");
}




/*

-(void)testVibrateOnFinish
{
  // player =

}
*/
@end
