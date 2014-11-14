//
//  AskForRatingAppDelegate.m
//  AskForRating
//
//  Created by Dave Wooldridge on 8/11/09, modified 10/30/2010.
// 
//  Example Project from the Apress book
//  The Business of iPhone and iPad App Development: Making and Marketing Apps that Succeed
//  http://www.iPhoneBusinessBook.com/
//

#import "AskForRatingAppDelegate.h"
#import "AskForRatingViewController.h"

@implementation AskForRatingAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
