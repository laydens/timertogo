//
//  SPLAboutViewController.m
//  TimerToGo
//
//  Created by Shannon on 12/28/12.
//  Copyright (c) 2012 Shannon. All rights reserved.
//

#import "SPLAboutViewController.h"
#import  <MessageUI/MessageUI.h>
@interface SPLAboutViewController ()
- (IBAction)cancel:(id)sender;
@end

@implementation SPLAboutViewController


- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    [self applyFonts];
    
   // [self.CancelButton setStyle:UIBarButtonSystemItemCancel];
    //self.CancelButton leftBarButtonItem
    
   // UIBarButton *rightCancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonSystemItemCancel target:nil action:(cancel)];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)showText
{
    
     NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    NSString *body = [NSString stringWithFormat:@"You're using Version %@. Please contact us if you have any problems or suggestions.",appVersion];
    
    
    self.Headline.text = @"Thank you for using Timer To Go!";
    self.textBody.text = body;
    self.buttonText.titleLabel.text = @"Send Email";

}

-(void)applyFonts
{

  UIFont *headlineFont = [UIFont fontWithName:@"Apple LiGothic" size:22];
  UIFont *bodyFont = [UIFont fontWithName:@"Apple LiGothic" size:16];
    
    self.Headline.font = headlineFont;
    self.textBody.font = bodyFont;
    self.buttonText.titleLabel.font = headlineFont;
    

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // static NSString *CellIdentifier = @"Cell";
  //  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
  UITableViewCell *cell =  [[UITableViewCell alloc]init];
    // Configure the cell...
    if(indexPath.row == 0)
    {
        NSString *blahBlahBlah = @"";
      cell.textLabel.text = blahBlahBlah;
        [cell setUserInteractionEnabled:NO];
    }
    else if(indexPath.row == 1)
    {
      cell.textLabel.text = @"";
    }
    else
    {
       cell.textLabel.text = @"";
    }
    
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void)viewDidUnload {
    
   
    [self setCancelButton:nil];
    [self setAboutToolbar:nil];
    [self setHeadline:nil];
    [self setTextBody:nil];
    [self setButtonText:nil];
    [super viewDidUnload];
}

- (IBAction)cancel:(id)sender {
    NSLog(@"cancel");
}


- (IBAction)CancelModal:(id)sender {
     [self  dismissViewControllerAnimated:YES completion:^{
         //
     }];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (IBAction)sendEmail:(id)sender
    {
        
        //MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        BOOL canSend = [MFMailComposeViewController canSendMail];
        
if(canSend)
{
    NSURL *url;
    NSString *buildType = @"";
    #ifdef FREE_VERSION
    buildType = @"free";
    #endif

        NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    NSString *mailtoUrl = [NSString stringWithFormat:@"mailto:timertogo@aporias.com?subject=Comments%%20on%%20Version:%@%%20%@",appVersion, buildType];
    url = [NSURL URLWithString:mailtoUrl];
        assert(url != nil);
        
        // Open the URL.
      [[UIApplication sharedApplication] openURL:url];
}else
{
    UIAlertView *cantSendAlert = [[UIAlertView alloc]initWithTitle:@"No email account" message:@"There's no email account set up on this device, but you can always reach us at timertogo@aporias.com." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
 
    [cantSendAlert show];
}
    }

@end
