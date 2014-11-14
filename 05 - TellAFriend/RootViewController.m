//
//  RootViewController.m
//  TellAFriend
//
//  Created by Dave Wooldridge on 8/12/09, modified on 10/30/2010.
// 
//  Example Project from the Apress book
//  The Business of iPhone and iPad App Development: Making and Marketing Apps that Succeed
//  http://www.iPhoneBusinessBook.com/
//

#import "RootViewController.h"


@implementation RootViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Add action button to navigation bar.
	UIBarButtonItem *actionButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(showShareOptions:)];
	self.navigationItem.rightBarButtonItem = actionButton;
    [actionButton release];
	
}

- (IBAction)showShareOptions:(id)sender {
	// Action button was tapped, so display Action Sheet.
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Like This App? Tell A Friend!" delegate:self cancelButtonTitle:@"Maybe Later" destructiveButtonTitle:nil otherButtonTitles:@"Send Email", @"Post on Twitter", @"Share on Facebook", nil];
    [actionSheet showInView:self.view];
    [actionSheet release];    
	
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
	if (buttonIndex != [actionSheet cancelButtonIndex]) {
		if (buttonIndex == 0) {
			// In-App Email, requires iOS 3.0 or higher
			[self showMailComposer];
		}
		if (buttonIndex == 1) {
			// Add Twitter code here.
		}
		if (buttonIndex == 2) {
			// Add Facebook code here.
		}
	}
}

// Displays an email composition interface inside the app and populates all the Mail fields. 
- (void)showMailComposer {
	
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil) {
		// Test to ensure that device is configured for sending emails.
		if ([mailClass canSendMail]) {
			
			MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
			picker.mailComposeDelegate = self;
			
			[picker setSubject:@"Check out this cool new app!"];
			
			// Fill out the email body text
			NSString *emailBody = @"Check out this cool new app for iPhone, iPad, and iPod touch - now available in the App Store!\n\nBreadcrumbs - Parked Car Locator\n\nWatch a video and learn more at:\nhttp://www.breadcrumbsapp.com/";
			[picker setMessageBody:emailBody isHTML:NO];
			
			[self presentModalViewController:picker animated:YES];
			[picker release];
			
		}
		else {
			// Device is not configured for sending emails, so notify user.
			UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Unable to Email" message:@"This device is not yet configured for sending emails." delegate:self cancelButtonTitle:@"Okay, I'll Try Later" otherButtonTitles:nil];
			[alertView show];
			[alertView release];			
		}
	}
	
}

// Dismisses the Mail composer when the user taps Cancel or Send.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	NSString *resultTitle = nil;
	NSString *resultMsg = nil;
	
	switch (result)
	{
		case MFMailComposeResultCancelled:
			resultTitle = @"Email Cancelled";
			resultMsg = @"You elected to cancel the email";
			break;
		case MFMailComposeResultSaved:
			resultTitle = @"Email Saved";
			resultMsg = @"You saved the email as a draft";
			break;
		case MFMailComposeResultSent:
			resultTitle = @"Email Sent";
			resultMsg = @"Your email was successfully delivered";
			break;
		case MFMailComposeResultFailed:
			resultTitle = @"Email Failed";
			resultMsg = @"Sorry, the Mail Composer failed. Please try again.";
			break;
		default:
			resultTitle = @"Email Not Sent";
			resultMsg = @"Sorry, an error occurred. Your email could not be sent.";
			break;
	}
	
	// Notifies user of any Mail Composer errors received with an Alert View dialog.
	UIAlertView *mailAlertView = [[UIAlertView alloc] initWithTitle:resultTitle message:resultMsg delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
	[mailAlertView show];
	[mailAlertView release];			
	[resultTitle release];			
	[resultMsg release];			
	
	[self dismissModalViewControllerAnimated:YES];
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}


@end
