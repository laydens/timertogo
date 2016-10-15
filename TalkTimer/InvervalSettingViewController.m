//
//  SPLViewController.m
//  TalkTimer
//
//  Created by Shannon on 11/30/12.
//  Copyright (c) 2012 Shannon. All rights reserved.
//

#import "InvervalSettingViewController.h"
#import "SPLCountDownViewController.h"
#import "SPLSoundPlayer.h"
#import "SPLBannerViewController.h"
#import "SPLLabeledPickerView.h"
@interface InvervalSettingViewController ()
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (strong, nonatomic) IBOutlet UIDatePicker *IntervalPicker;
@property (strong, nonatomic) IBOutlet UILabel *iLabel;
@property  NSTimeInterval Interval;
@property (strong, nonatomic) SPLBannerViewController *bannerManage;
@property SPLLabeledPickerView *pickerView;
@property bool isInitialized;
@end

@implementation InvervalSettingViewController
@synthesize IntervalPicker;
@synthesize iLabel;
@synthesize Interval;

@synthesize bannerManage;
@synthesize isInitialized;
@synthesize hoursArray;
@synthesize minsArray;
@synthesize secsArray;

#pragma mark -
#pragma mark initialization
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CGRect pickerFrame = CGRectMake(self.view.frame.origin.x, self.toolBar.frame.size.height, 320, 260.0);

    self.pickerView = [[SPLLabeledPickerView alloc]initWithFrame:pickerFrame];
    [self.pickerView addLabel:@"hours" forComponent:0 forLongestString:@"hours"];
    [self.pickerView addLabel:@"mins" forComponent:1 forLongestString:@"mins"];
    [self.pickerView addLabel:@"secs" forComponent:2 forLongestString:@"secs"];
    self.pickerView.delegate = self;
    (self.pickerView).showsSelectionIndicator;
    (self.pickerView).backgroundColor = [UIColor whiteColor];
      
    
       [self.parentView addSubview:self.pickerView];
    //initialize arrays
    hoursArray = [[NSMutableArray alloc] init];
    minsArray = [[NSMutableArray alloc] init];
    secsArray = [[NSMutableArray alloc] init];
    NSString *strVal; //= [[NSString alloc] init];

    for(int i=0; i<61; i++)
    {
        strVal = [NSString stringWithFormat:@"%d", i];
        
        //NSLog(@"strVal: %@", strVal);
        
        //Create array with 0-12 hours
        if (i < 25)
        {
            [hoursArray addObject:strVal];
        }
        
        //create arrays with 0-60 secs/mins
        [minsArray addObject:strVal];
        [secsArray addObject:strVal];
    }
  //  [self calculateTimeFromPicker];
    
    NSLog(@"[hoursArray count]: %d", hoursArray.count);
    NSLog(@"[minsArray count]: %d", minsArray.count);
    NSLog(@"[secsArray count]: %d", secsArray.count);
    
    self.Interval = IntervalPicker.countDownDuration;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"%@",segue.identifier);
    if ([segue.identifier isEqualToString:@"toCountdown"]) {
        
        SPLCountDownViewController *vc = segue.destinationViewController;
        [vc startTimer:self.Interval];
        
    }else
    {
    }
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

-(void)IntervalChanged:(id)sender
{
    //Interval =   //[IntervalPicker countDownDuration];
    //iLabel.text = [NSString stringWithFormat:@"%f",Interval];
    NSLog(@"%f",self.Interval);
}

- (void)viewDidUnload
{
    [self setIntervalPicker:nil];
    [self setILabel:nil];

    [self setMyBannerView:nil];
    [self setParentView:nil];
    [self setPickerView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;// (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)IndicateGo:(id)sender {
    if(self.Interval > 9)
    {
    SPLSoundPlayer *player = [[SPLSoundPlayer alloc] initWithPath:@"pingclick.aif"];
    [player play];
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please the timer to at least 10 seconds." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
        [alert show];
        
    
    }
}


//Method to define how many columns/dials to show
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}


// Method to define the numberOfRows in a component using the array.
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent :(NSInteger)component
{
    if (component==0)
    {
        return hoursArray.count;
    }
    else if (component==1)
    {
        return minsArray.count;
    }
    else
    {
        return secsArray.count;
    }
    
    
}


// Method to show the title of row for a component.
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
 
    
    switch (component)
    {
        case 0:
            return hoursArray[row];
            break;
        case 1:
            return minsArray[row];
            break;
        case 2:
            return secsArray[row];
            break;
    }
    return nil;
    
    if(row == secsArray.count)
    {
     [self.pickerView selectRow:2 inComponent:1 animated:YES];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{

    [self calculateTimeFromPicker];

}


-(void)calculateTimeFromPicker
{
    
    NSString *hoursStr = [NSString stringWithFormat:@"%@",hoursArray[[self.pickerView selectedRowInComponent:0]]];
    
    NSString *minsStr = [NSString stringWithFormat:@"%@",minsArray[[self.pickerView selectedRowInComponent:1]]];
    
    NSString *secsStr = [NSString stringWithFormat:@"%@",secsArray[[self.pickerView selectedRowInComponent:2]]];
    
    int hoursInt = hoursStr.intValue;
    int minsInt = minsStr.intValue;
    int secsInt = secsStr.intValue;
    
    
    self.Interval = secsInt + (minsInt*60) + (hoursInt*3600);
    
    NSLog(@"hours: %d ... mins: %d .... sec: %d .... interval: %f", hoursInt, minsInt, secsInt, self.Interval);
    
    if(self.Interval == 0 && !self.isInitialized)
    {
       
        [self.pickerView selectRow:5 inComponent:1 animated:YES];
        //we're only setting it to 5 minutes on the initial load. Otherwise is can be zero if the user sets it that way.
         self.isInitialized = true;
    }
    
   // NSString *totalTimeStr = [NSString stringWithFormat:@"%f",interval];
    
}



@end
