//
//  AskForRatingAppDelegate.h
//  AskForRating
//
//  Created by Dave Wooldridge on 8/11/09, modified 10/30/2010.
// 
//  Example Project from the Apress book
//  The Business of iPhone and iPad App Development: Making and Marketing Apps that Succeed
//  http://www.iPhoneBusinessBook.com/
//

#import <UIKit/UIKit.h>

@class AskForRatingViewController;

@interface AskForRatingAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    AskForRatingViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet AskForRatingViewController *viewController;

@end

