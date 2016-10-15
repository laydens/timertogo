//
//  SPLAboutViewController.h
//  TimerToGo
//
//  Created by Shannon on 12/28/12.
//  Copyright (c) 2012 Shannon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPLAboutViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *CancelButton;
@property (weak, nonatomic) IBOutlet UILabel *Headline;
@property (weak, nonatomic) IBOutlet UILabel *textBody;
@property (weak, nonatomic) IBOutlet UIButton *buttonText;

- (IBAction)CancelModal:(id)sender;
- (IBAction)sendEmail:(id)sender;

@property (weak, nonatomic) IBOutlet UIToolbar *aboutToolbar;

@end
