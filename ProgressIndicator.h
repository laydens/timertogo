//
//  ProgressIndicator.h
//  TalkTimer
//
//  Created by Shannon on 12/17/12.
//  Copyright (c) 2012 Shannon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressIndicator : UIView
@property bool isDefaultColor;
@property double percentComplete;
-(void)updateProgress;
typedef NS_ENUM(unsigned int, Colors) {Orange,Blue,Green};

@end
