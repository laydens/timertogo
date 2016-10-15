//
//  UIColor+Colors.h
//  TalkTimer
//
//  Created by Shannon on 12/19/12.
//  Copyright (c) 2012 Shannon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Colors)

+ (UIColor *)lightestLimeGreen;
+ (UIColor *)lighterLimeGreen;
+ (UIColor *)lightLimeGreen;
+ (UIColor *)darkLimeGreen;

+ (UIColor *)lightestBlue;
+ (UIColor *)lighterBlue;
+ (UIColor *)lightBlue;
+ (UIColor *)greyLightBlue;

+ (UIColor *)lightestOrange;
+ (UIColor *)lighterOrange;
+ (UIColor *)lightOrange;
+ (UIColor *)darkOrange;

- (UIColor *)colorByChangingAlphaTo:(CGFloat)newAlpha;
@end
