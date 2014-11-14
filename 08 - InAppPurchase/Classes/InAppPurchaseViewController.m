//
//  InAppPurchaseViewController.m
//  InAppPurchase
//
//  Created by Dave Wooldridge on 9/15/2009.
//  Modified by Dave on 1/27/2011.
//
//  Example Project from the Apress book
//  The Business of iPhone and iPad App Development: Making and Marketing Apps that Succeed
//  http://www.iPhoneBusinessBook.com/
//
// ----------------------------------------------------------
// Do not use this example project as is. In order for it to 
// run on your connected test device via Xcode, you must first 
// customize the code with your own In-App Purchase Product IDs
// and other related app info. Please read Chapter 8 for details.
// ----------------------------------------------------------
// 

#import "InAppPurchaseViewController.h"

@implementation InAppPurchaseViewController
@synthesize inappObserver;
@synthesize inappButton;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	inappObserver = [[InAppPurchaseObserver alloc] init];

	if ([SKPaymentQueue canMakePayments]) {
		// Yes, In-App Purchase is enabled on this device!
		// Proceed to fetch available In-App Purchase items.
		
		// Replace "Your IAP Product ID" with your actual In-App Purchase Product ID,
		// fetched from either a remote server or stored locally within your app. 
		SKProductsRequest *prodRequest= [[SKProductsRequest alloc] initWithProductIdentifiers: [NSSet setWithObject: @"Your IAP Product ID"]];
		prodRequest.delegate = self;
		[prodRequest start];
		
	} else {
		// Notify user that In-App Purchase is disabled via button text.
		[inappButton setTitle:@"In-App Purchase is Disabled" forState:UIControlStateNormal];
		inappButton.enabled = NO;
	}	
	
    [super viewDidLoad];
}

// Store Kit returns a response from an SKProductsRequest.
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {

	// Populate the inappBuy button with the received product info.
	SKProduct *validProduct = nil;
	int count = [response.products count];
	if (count>0) {
		validProduct = [response.products objectAtIndex:0];
	}
	if (!validProduct) {
		[inappButton setTitle:@"No Products Available" forState:UIControlStateNormal];
		inappButton.enabled = NO;
		return;
	}
	
	NSString *buttonText = [[NSString alloc] initWithFormat:@"%@ - Buy %@", validProduct.localizedTitle, validProduct.price];
	[inappButton setTitle:buttonText forState:UIControlStateNormal];
	inappButton.enabled = YES;
	[buttonText release];
}

// When the buy button is clicked, start In-App Purchase process.
-(IBAction)buyInApp:(id)sender {
	
	// Replace "Your IAP Product ID" with your actual In-App Purchase Product ID.
	SKPayment *paymentRequest = [SKPayment paymentWithProductIdentifier: @"Your IAP Product ID"]; 

	// Assign an Observer class to the SKPaymentTransactionObserver,
	// so that it can monitor the transaction status.
	[[SKPaymentQueue defaultQueue] addTransactionObserver:inappObserver];
	
	// Request a purchase of the selected item.
	[[SKPaymentQueue defaultQueue] addPayment:paymentRequest];

}

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[inappButton release];
	[inappObserver release];
    [super dealloc];
}

@end
