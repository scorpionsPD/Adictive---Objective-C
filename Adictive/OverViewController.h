//
//  OverViewController.h
//  Adictive
//
//  Created by Pradeep Dahiya on 16/12/14.
//  Copyright (c) 2014 Pradeep Dahiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ADTickerLabel/ADTickerLabel.h>
#import <GameKit/GameKit.h>
#import "HMSideMenu.h"
#import <MessageUI/MessageUI.h>
#import <Social/Social.h>

@interface OverViewController : UIViewController <MFMailComposeViewControllerDelegate,UINavigationControllerDelegate,GKLeaderboardViewControllerDelegate,GKGameCenterControllerDelegate>
{
    
    int second;
    NSString *lederboardCategory;
}
@property(nonatomic)double score;
@property (nonatomic, strong) ADTickerLabel *scoreLable;
@property (nonatomic, strong) ADTickerLabel *timeBonus;
@property (nonatomic, strong) ADTickerLabel *total;
@property (nonatomic, strong) HMSideMenu *sideMenu;
-(void)initWithScoreData:(double)score sec:(int)sec;

@end
