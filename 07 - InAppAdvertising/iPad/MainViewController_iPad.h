//
//  MainViewController_iPad.h
//  InAppAdv
//
//  Created by Dave Wooldridge on 12/14/10.
//
//  Example Project from the Apress book
//  The Business of iPhone and iPad App Development: Making and Marketing Apps that Succeed
//  http://www.iPhoneBusinessBook.com/
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@class Reachability;

@interface MainViewController_iPad : UIViewController <ADBannerViewDelegate> {
	
	UIView *contentView;
    ADBannerView *adBannerView;
	UIButton *altAdBannerButton;
	Reachability* netReachable;
	BOOL isNetAvailable;
}

@property (nonatomic, retain) IBOutlet UIView *contentView;
@property (nonatomic, retain) IBOutlet ADBannerView *adBannerView;
@property (nonatomic, retain) IBOutlet UIButton *altAdBannerButton;

- (void)reachabilityChanged:(NSNotification*)note;
- (void)prepareAdBannerView;
- (void)prepareAltAdBanner;
- (void)adjustAdBannerPosition:(BOOL)animated;
- (void)tappedAltAdBanner;

@end
