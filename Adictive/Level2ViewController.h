//
//  Level2ViewController.h
//  Adictive
//
//  Created by Pradeep Dahiya on 19/12/14.
//  Copyright (c) 2014 Pradeep Dahiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSMessage.h"
#import "TSMessageView.h"
#import <ADTickerLabel/ADTickerLabel.h>
#import "AppDelegate.h"

@class GADBannerView;
@interface Level2ViewController : UIViewController{
    
    int fristRandomButton;
    int subLevelCount;
    int tapCount;
    int sucessCount;
    int boxCount;
    int score;
    int orderChk;
    int levelCount;
    int blinkCounter;
    int pressCount;
    BOOL isLevelFailed;
    SystemSoundID btnClickSound;
    NSMutableArray *chkOrderArray;
    
    UIButton*btn1;
    IBOutlet UILabel *levelNo;
}
@property (strong, nonatomic) UIImageView *wait;
@property(nonatomic, strong) IBOutlet GADBannerView *bannerView;
@property (nonatomic, strong) ADTickerLabel *scoreLable;
@property (nonatomic, strong) NSMutableArray *btnArray;
@end
