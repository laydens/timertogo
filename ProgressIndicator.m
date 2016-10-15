//
//  ProgressIndicator.m
//  TalkTimer
//
//  Created by Shannon on 12/17/12.
//  Copyright (c) 2012 Shannon. All rights reserved.
//

#import "ProgressIndicator.h"
#import "UIColor+Colors.h"
@interface ProgressIndicator()

@property Colors currentColor;
@property Colors previousColor;
@end


@implementation ProgressIndicator
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

//typedef enum {Orange,Blue,Green} Colors;
@synthesize isDefaultColor;
@synthesize percentComplete;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.percentComplete = 0;
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    /*
     CGContextRef ctx = UIGraphicsGetCurrentContext();
     CGContextAddEllipseInRect(ctx, rect);
     CGContextSetFillColor(ctx, CGColorGetComponents([[UIColor blueColor] CGColor]));
     CGContextFillPath(ctx);
     */
    
    self.isDefaultColor = YES;
    if(self.percentComplete > 0)
    {
        [self updateProgress];
    }
    //[self DrawArcWithColor:Green percentComplete:0];
    
}







-(void)updateProgress
{
    //int tenthOfPercent = self.percentComplete*100;
    int percent = self.percentComplete;
    //This is so we can update every tenth
    if(percent < 100)
    {
        //first circle is green.
        self.currentColor = Green;
        
    }else if(self.currentColor == Green && percent == 100)
    {
        //second circle is orange
        self.currentColor = Orange;
        self.previousColor = Orange;
    }
    //Then the circles alternate between blue and orange for each revolution.
    // This only works if this method is called every time the percent moves up by 1.
    else if(percent%100 == 0 && self.currentColor == Orange && self.previousColor == Orange)
    { 
        self.currentColor = Blue;
       
    }else if(percent%100 == 0 && self.currentColor == Blue && self.previousColor == Blue)
    {
        self.currentColor = Orange;
    }
    
    if(percent%100 == 99)
    {
    {self.previousColor = self.currentColor;}
    }
    
    [self DrawArcWithColor:self.currentColor];
}


-(void)DrawArcWithColor:(Colors)circleColor
{
    
    
    UIColor *innerColor;
    UIColor *Color2;
    UIColor *Color3;
    UIColor *Color4;
    UIColor *Blend;
    UIColor *Fade;
    UIColor *Glow;
    UIColor *Dim;
    
    int degrees = self.percentComplete*360*.01;
   // NSLog(@"drawing percentComplete:%f",self.percentComplete);
    if(circleColor == Green)
    {
        innerColor = [UIColor lightestLimeGreen];
        Color2 = [UIColor lighterLimeGreen];
        Color3 = [UIColor lightLimeGreen];
        Color4 = [UIColor darkLimeGreen];
  
    
    }
    else if(circleColor == Orange)
    {
        innerColor = [UIColor lightestOrange];
        Color2 = [UIColor lighterOrange];
        Color3 = [UIColor lightOrange];
        Color4 = [UIColor darkOrange];
    
    }
    else
    {
        innerColor = [UIColor lightestBlue];
        Color2 = [UIColor lighterBlue];
        Color3 = [UIColor lightBlue];
        Color4 = [UIColor greyLightBlue];
      
        
    }
    
    Dim =  [innerColor colorByChangingAlphaTo:.01];
    Glow = [innerColor colorByChangingAlphaTo:.04];
    Fade = [innerColor colorByChangingAlphaTo:.09];
    Blend = [innerColor colorByChangingAlphaTo:.2];
    
    [self DrawArcWithThickness:19 Hue:Glow circleDegrees:degrees];
    [self DrawArcWithThickness:17 Hue:Glow circleDegrees:degrees];
    [self DrawArcWithThickness:15 Hue:Fade circleDegrees:degrees];
    [self DrawArcWithThickness:13 Hue:Blend circleDegrees:degrees];
    
    [self DrawArcWithThickness:11 Hue:innerColor  circleDegrees:degrees];
    [self DrawArcWithThickness:10 Hue:Color2 circleDegrees:degrees];
    [self DrawArcWithThickness:7 Hue:Color3 circleDegrees:degrees];
    [self DrawArcWithThickness:5 Hue:Color4 circleDegrees:degrees];
    
    
    // Colors myColors;
    
    
}






-(void)DrawArcWithThickness:(int)thickness Hue:(UIColor*)Color circleDegrees:(int)degrees
{
    int workingDegrees = degrees%360;
   // NSLog(@"workingDegrees:%d",workingDegrees);
   // NSLog(@"degrees:%d",degrees);
    CGFloat centerX =  self.frame.size.width/2-1;
    CGFloat centerY = self.frame.size.height/2;
    CGPoint center = CGPointMake(centerX, centerY);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:79 startAngle:DEGREES_TO_RADIANS(-90) endAngle:DEGREES_TO_RADIANS(workingDegrees-90) clockwise:YES];
    [Color setStroke];
    path.lineWidth = thickness + 5;
    path.lineCapStyle = kCGLineCapRound;
    [path stroke];
}



@end

