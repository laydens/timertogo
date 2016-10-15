//
//  SPLSoundPlayer.m
//  TalkTimer
//
//  Created by Shannon on 12/13/12.
//  Copyright (c) 2012 Shannon. All rights reserved.
//

#import "SPLSoundPlayer.h"
#import <AudioToolbox/AudioToolbox.h>

@interface SPLSoundPlayer()

@end
@implementation SPLSoundPlayer
@synthesize fullpath;
@synthesize handle;

-(instancetype)initWithPath:(NSString *) path
{
   self = [super init];
   if(path.length != 0)
   {
       [self CreateSoundHandle:path];
   }
    return self;
}

- (instancetype)init
{
        return [self initWithPath:@""];
}


-(void)CreateSoundHandle:(NSString *)soundFile
{
        NSString *resourceDir = [NSBundle mainBundle].resourcePath;
        self.fullpath = [resourceDir stringByAppendingPathComponent:soundFile];
        NSLog(@"%@",self.fullpath);
        NSURL *url = [NSURL fileURLWithPath:self.fullpath];
        
        OSStatus errcode = AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &handle);
        NSAssert1(errcode==0,@"Failed to load sound: %@", soundFile);
    if(errcode==0)
    {
       NSLog(@"OSStatus :%ld - soundFile: %@",errcode, soundFile);
    }

}


- (void) play
{
    AudioServicesPlaySystemSound(handle);
}

-(void)vibrate
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

@end
