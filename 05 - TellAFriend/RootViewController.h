//
//  RootViewController.h
//  TellAFriend
//
//  Created by Dave Wooldridge on 8/12/09, modified on 10/30/2010.
// 
//  Example Project from the Apress book
//  The Business of iPhone and iPad App Development: Making and Marketing Apps that Succeed
//  http://www.iPhoneBusinessBook.com/
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface RootViewController : UIViewController <UIActionSheetDelegate, MFMailComposeViewControllerDelegate> {

}

- (IBAction)showShareOptions:(id)sender;
- (void)showMailComposer;

@end
