//
//  MainViewController_iPad.m
//  InAppAdv
//
//  Created by Dave Wooldridge on 12/14/10.
//
//  Example Project from the Apress book
//  The Business of iPhone and iPad App Development: Making and Marketing Apps that Succeed
//  http://www.iPhoneBusinessBook.com/
//

#import "MainViewController_iPad.h"
#import "Reachability.h"

@implementation MainViewController_iPad

@synthesize contentView;
@synthesize adBannerView;
@synthesize altAdBannerButton;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Check the current device's Internet connection
	// using Apple's Reachability classes. When the status
	// changes, a notification is posted, calling the
	// reachabilityChanged method.
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
	netReachable = [[Reachability reachabilityWithHostName: @"www.apple.com"] retain];
	[netReachable startNotifier];
		
	// Configure and request an iAd banner.
	[self prepareAdBannerView];
	
	// Configure an alternate ad banner in the event
	// that an iAd banner is not available.
	[self prepareAltAdBanner];
	
	// Adjust the app UI to display the ad banner
	// view at the bottom of the screen.
	[self adjustAdBannerPosition:NO];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	[self adjustAdBannerPosition:NO];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	
	[self adjustAdBannerPosition:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES to support both Portrait and Landscape orientations.
    return YES;
}

//Called by Reachability whenever status changes.
- (void) reachabilityChanged: (NSNotification* )note {
	
	NetworkStatus netStatus = [netReachable currentReachabilityStatus];
	switch (netStatus)
	{
		case NotReachable:
		{
			isNetAvailable = NO;
			break;
		}
		case ReachableViaWiFi:
		{
			isNetAvailable = YES;
			break;
		}
		case ReachableViaWWAN:
		{
			isNetAvailable = YES;
			break;
		}
	}
}

- (void)prepareAdBannerView {
	// This method creates and configures the iAd banner view offscreen.
	
	// Calculate the size of the banner view based on the device's current orientation.
	NSString *adBannerSize = UIInterfaceOrientationIsPortrait([UIDevice currentDevice].orientation) ? ADBannerContentSizeIdentifierPortrait : ADBannerContentSizeIdentifierLandscape;
    
	// Initially, this iAd banner view will be placed offscreen.
	// Once an ad is ready to be shown, then the ad banner view will be displayed.
	CGRect adFrame;
	adFrame.size = [ADBannerView sizeFromBannerContentSizeIdentifier:adBannerSize];
	adFrame.origin = CGPointMake(0.0, CGRectGetMaxY(self.view.bounds));
    
	// Create the iAd banner.
	ADBannerView *adBanner = [[ADBannerView alloc] initWithFrame:adFrame];
	
	// Set iAd banner's delegate to self, so that iAd notifications can be received.
	adBanner.delegate = self;
	
	// Inform the iAd network of the ad sizes the app supports (in this case, both portrait and landscape).
	adBanner.requiredContentSizeIdentifiers = [NSSet setWithObjects:ADBannerContentSizeIdentifierPortrait, ADBannerContentSizeIdentifierLandscape, nil];
    
	// Add the iAd banner view to the parent view.
	// It is now requesting an ad from the iAd Network.
	[self.view addSubview:adBanner];
	self.adBannerView = adBanner;
	[adBanner release];
	[adBannerSize release];
}

- (void)prepareAltAdBanner {
	// This method creates and configures a custom house ad banner offscreen
	// in the event that an iAd banner is not available. But the code below could
	// be easily replaced to show an ad from another ad network like AdMob.
	
	// Create the alternate ad banner based on the device's current orientation.
	UIImage *altAdImg = [[[UIImage alloc] init] autorelease];
	NSString *adBannerImage = [[NSString alloc] init];
	if (UIInterfaceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
		adBannerImage = @"adbannerlandscape-ipad.png";
	} else {
		adBannerImage = @"adbannerportrait-ipad.png";
	}
	altAdImg = [UIImage imageNamed:adBannerImage];
	
	UIButton *altButton = [[UIButton buttonWithType:UIButtonTypeCustom] autorelease];
	[altButton setBackgroundImage:altAdImg forState:UIControlStateNormal];
	[altButton addTarget:self action:@selector(tappedAltAdBanner) forControlEvents:UIControlEventTouchUpInside];
	self.altAdBannerButton = altButton;
	
	// Initially, this ad banner will be placed offscreen.
	// Once the ad is ready to be shown, then the ad banner will be displayed.
	CGRect adFrame = CGRectMake(0.0, CGRectGetMaxY(self.view.bounds), altAdImg.size.width, altAdImg.size.height);
	self.altAdBannerButton.frame = adFrame;
	
	// Add the alternate ad banner to the parent view.
	[self.view addSubview:self.altAdBannerButton];	
	[adBannerImage release];
}

- (void)tappedAltAdBanner {
	// The user has tapped the alternate ad banner, so perform an action.
	// For this simple example, the alternate ad banner links to a URL.
	NSURL *url = [NSURL URLWithString:@"http://www.iPhoneBusinessBook.com/"];
	[[UIApplication sharedApplication] openURL:url];
	
}

- (void)adjustAdBannerPosition:(BOOL)animated {
	// Set up some initial properties for calculating positions and animation.
    CGFloat animationDuration = animated ? 0.3 : 0.0;
	CGRect viewFrame = self.view.bounds;
	CGFloat iAdPosition = self.view.frame.size.height;
	CGFloat iAdHeight = 0.0;
	CGFloat altAdPosition = self.view.frame.size.height;
	CGFloat altAdWidth = 0.0;
	CGFloat altAdHeight = 0.0;
	UIImage *altAdImage = [[[UIImage alloc] init] autorelease];
	if (UIInterfaceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
		// Landscape iPad Height: 768 - 20 pixel status bar = 748.
		adBannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierLandscape;
		iAdPosition = 748.0;
		// Landscape iAd Banner Size: 1024 width, 66 height.
		iAdHeight = adBannerView.frame.size.height;
		altAdImage = [UIImage imageNamed:@"adbannerlandscape-ipad.png"];
		altAdPosition = 748.0;
	} else {
		// Portrait iPad Height: 1024 - 20 pixel status bar = 1004.
		adBannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
		iAdPosition = 1004.0;
		// Portrait iAd Banner Size: 768 width, 66 height.
		iAdHeight = adBannerView.frame.size.height;
		altAdImage = [UIImage imageNamed:@"adbannerportrait-ipad.png"];
		altAdPosition = 1004.0;
	}
	[altAdBannerButton setBackgroundImage:altAdImage forState:UIControlStateNormal];
	altAdWidth = altAdImage.size.width;
	altAdHeight = altAdImage.size.height;
	
	// Check status of Internet connection to decide whether or not to show an ad.
	if (isNetAvailable) {
		// YES, Internet connection is available, so show ad banner.
				
		if (adBannerView.bannerLoaded) {
			// An iAd was successfully loaded into the ad banner, so slide it into view.
			// Also resize contentView height to make room for the ad banner at the bottom.
						
			// Adjust height for contentView above iAd banner.
			viewFrame.size.height -= iAdHeight;
			
			// Since alternate ad banner is not being used, adjust it's position offscreen.
			altAdPosition += altAdHeight;
			
			// Now adjust onscreen position for iAd banner.
			iAdPosition -= iAdHeight;
			
		} else {
			// iAd not available or an error occurred, so show alternate ad banner instead.
			// For this example, a custom house ad is shown, but the code below could be 
			// easily replaced to show an ad from another ad network like AdMob.
						
			// Adjust height for contentView above alternative ad banner.
			viewFrame.size.height -= altAdHeight;
			
			// Since iAd is not being used, adjust iAd position offscreen.
			iAdPosition += iAdHeight;
			
			// Now adjust onscreen position for alternate ad banner.
			altAdPosition -= altAdHeight;
		}
		
	} else {
		// NO, Internet connection is NOT available, so hide ad banner.
		
		// Move both banner views offscreen.
		iAdPosition += iAdHeight;
		altAdPosition += altAdHeight;
	}
	
	// Slide the requested ad banner into view, and move the other ad banner view offscreen.
	[UIView animateWithDuration:animationDuration animations:^{
		contentView.frame = viewFrame;
		[contentView layoutIfNeeded];
		adBannerView.frame = CGRectMake(0.0, iAdPosition, adBannerView.frame.size.width, adBannerView.frame.size.height);
		altAdBannerButton.frame = CGRectMake(0.0, altAdPosition, altAdWidth, altAdHeight);
	}];
	
}

// As an ADBannerViewDelegate, this class will receive messages from the
// iAd framework, notifying your app if an iAd banner was loaded or not.
#pragma mark ADBannerViewDelegate methods

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
	
	[self adjustAdBannerPosition:YES];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
	
	[self adjustAdBannerPosition:YES];
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave {
	
    return YES;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner {
}
// End of the ADBannerViewDelegate methods


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    self.contentView = nil;
    adBannerView.delegate = nil;
    self.adBannerView = nil;
    [super viewDidUnload];
}

- (void)dealloc {
	[contentView release];
    adBannerView.delegate = nil;
    [adBannerView release];
    [altAdBannerButton release];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

@end
