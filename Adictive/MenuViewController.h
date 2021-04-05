//
//  MenuViewController.h
//  Adictive
//
//  Created by Pradeep Dahiya on 02/12/14.
//  Copyright (c) 2014 Pradeep Dahiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTAnimatedLabel.h"
#import "GUAAlertView.h"
#import "GADInterstitial.h"
#import "GADInterstitialDelegate.h"
#import "AppDelegate.h"

@interface MenuViewController : UIViewController<UIScrollViewDelegate,GADInterstitialDelegate>
{
    AppDelegate *apdelegate;
    BOOL isSoundOn;
}
@property (strong, nonatomic) IBOutlet MTAnimatedLabel *animatedLabel;
@property (strong, nonatomic) IBOutlet MTAnimatedLabel *animatedLabel1;
@property (strong, nonatomic) IBOutlet UIScrollView *scroolView;
@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;
/// The interstitial ad.
@property(nonatomic, strong) GADInterstitial *interstitial;
//@property (weak, nonatomic) IBOutlet UIButton *musicBtn;
//@property (weak, nonatomic) IBOutlet UIButton *soundBtn;
@end
