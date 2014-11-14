//
//  InAppPurchaseAppDelegate.h
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

#import <UIKit/UIKit.h>

@class InAppPurchaseViewController;

@interface InAppPurchaseAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    InAppPurchaseViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet InAppPurchaseViewController *viewController;

@end

