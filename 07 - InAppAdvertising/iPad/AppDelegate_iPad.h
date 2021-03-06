//
//  AppDelegate_iPad.h
//  InAppAdv
// 
//  Created by Dave Wooldridge on 12/14/10.
//
//  Example Project from the Apress book
//  The Business of iPhone and iPad App Development: Making and Marketing Apps that Succeed
//  http://www.iPhoneBusinessBook.com/
//

#import <UIKit/UIKit.h>

@class MainViewController_iPad;

@interface AppDelegate_iPad : NSObject <UIApplicationDelegate> {
    UIWindow *window;

    MainViewController_iPad *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MainViewController_iPad *viewController;

@end

