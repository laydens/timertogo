//
//  UIColor+Colors.m
//  TalkTimer
//
//  Created by Shannon on 12/19/12.
//  Copyright (c) 2012 Shannon. All rights reserved.
//
/*
 lightestgreen
 203
 255
 92
 
 lightergreen
 173.0
 255.0
 0
 
 lightgreen
 135.0
 199.0
 0
 
 darklightgreen
 98.0
 144.0
 0
 
 
 lightestblue
 147.0
 244.0
 255.0
 
 lighterblue
 0
 299.0
 255.0
 
 
 lightblue
 0
 197.0
 220.0
 
 greyblue
 0
 151.0
 168.0
 
 
 */

#import "UIColor+Colors.h"

@implementation UIColor (Colors)





+ (UIColor *)lightestLimeGreen {

    // lightestgreen
   // 203
   // 255
   // 92
    return [UIColor colorWithRed:203.0/255.0 green:255.0/255.0 blue:92/255.0 alpha:1.0];
};

// lightergreen
//173
//255.0
//0
+ (UIColor *)lighterLimeGreen {
    return [UIColor colorWithRed:173.0/255.0 green:255.0/255.0 blue:0/255.0 alpha:1.0];
};

//lightgreen
//135.0
//199.0
//0

+ (UIColor *)lightLimeGreen {
    return [UIColor colorWithRed:135.0/255.0 green:199.0/255.0 blue:0/255.0 alpha:1.0];
};

//darklightgreen
//98.0
//144.0
//0
+ (UIColor *)darkLimeGreen {
    return [UIColor colorWithRed:98.0/255.0 green:144.0/255.0 blue:0/255.0 alpha:1.0];
};




+ (UIColor *)lightestBlue {
    return [UIColor colorWithRed:147.0/255.0 green:244.0/255.0 blue:255.0/255.0 alpha:1.0];
};

//
//lighterblue
//0
//299.0
//255.0
+ (UIColor *)lighterBlue {
    return [UIColor colorWithRed:56.0/255.0 green:299.0/255.0 blue:255.0/255.0 alpha:1.0];
};

//
//lightblue
//0
//197.0
//220.0
+ (UIColor *)lightBlue {
    return [UIColor colorWithRed:0/255.0 green:197.0/255.0 blue:220.0/255.0 alpha:1.0];
};

//greyblue
//0
//151.0
//168.0
+ (UIColor *)greyLightBlue {
    return [UIColor colorWithRed:0/255.0 green:151.0/255.0 blue:168.0/255.0 alpha:1.0];
};



+ (UIColor *)lightestOrange {
    return [UIColor colorWithRed:255.0/255.0 green:180.0/255.0 blue:107.0/255.0 alpha:1.0];
};
//lighterOrange
//255.0
//157.0
//62.0
//
+ (UIColor *)lighterOrange {
    return [UIColor colorWithRed:255.0/255.0 green:157.0/255.0 blue:62.0/255.0 alpha:1.0];
};
//lightOrange
//255.0
//126.0
//0
//
+ (UIColor *)lightOrange {
    return [UIColor colorWithRed:255.0/255.0 green:126.0/255.0 blue:0/255.0 alpha:1.0];
};
//darkOrange
//200.0
//99.0
//0
+ (UIColor *)darkOrange {
    return [UIColor colorWithRed:200.0/255.0 green:99.0/255.0 blue:0/255.0 alpha:1.0];
};

- (UIColor *)colorByChangingAlphaTo:(CGFloat)newAlpha;
{
	// oldComponents is the array INSIDE the original color
	// changing these changes the original, so we copy it
	CGFloat *oldComponents = (CGFloat *)CGColorGetComponents(self.CGColor);
	int numComponents = CGColorGetNumberOfComponents(self.CGColor);
	CGFloat newComponents[4];
    
	switch (numComponents)
	{
		case 2:
		{
			//grayscale
			newComponents[0] = oldComponents[0];
			newComponents[1] = oldComponents[0];
			newComponents[2] = oldComponents[0];
			newComponents[3] = newAlpha;
			break;
		}
		case 4:
		{
			//RGBA
			newComponents[0] = oldComponents[0];
			newComponents[1] = oldComponents[1];
			newComponents[2] = oldComponents[2];
			newComponents[3] = newAlpha;
			break;
		}
	}
    
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGColorRef newColor = CGColorCreate(colorSpace, newComponents);
	CGColorSpaceRelease(colorSpace);
    
	UIColor *retColor = [UIColor colorWithCGColor:newColor];
	CGColorRelease(newColor);
    
	return retColor;
}


@end
