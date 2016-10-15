//
//  SPLViewController.h
//  TalkTimer
//
//  Created by Shannon on 11/30/12.
//  Copyright (c) 2012 Shannon. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface InvervalSettingViewController : UIViewController<UIPickerViewDelegate>

- (IBAction)IndicateGo:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *MyBannerView;
@property (weak, nonatomic) IBOutlet UIView *parentView;

    
//@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property(strong, nonatomic) NSMutableArray *hoursArray;
@property(strong, nonatomic) NSMutableArray *minsArray;
@property(strong, nonatomic) NSMutableArray *secsArray;

@end
