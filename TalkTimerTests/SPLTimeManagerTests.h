//
//  SPLTimeManagerTests.h
//  TalkTimer
//
//  Created by Shannon on 12/17/12.
//  Copyright (c) 2012 Shannon. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "SPLTimerClient.h"
#import "SPLTimeManager.h"

@interface SPLTimeManagerTests : SenTestCase<SPLTimerClient>
-(void)UpdateUi;
@end
