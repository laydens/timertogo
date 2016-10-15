//
//  SPLSoundPlayer.h
//  TalkTimer
//
//  Created by Shannon on 12/13/12.
//  Copyright (c) 2012 Shannon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface SPLSoundPlayer : NSObject

-(instancetype)initWithPath:(NSString *) path NS_DESIGNATED_INITIALIZER;
-(void)play;
-(void)vibrate;
@property   NSString *fullpath;
@property SystemSoundID handle;
-(void)CreateSoundHandle:(NSString *)soundFile;

@end
