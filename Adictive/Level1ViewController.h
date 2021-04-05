//
//  Level1ViewController.h
//  Adictive
//
//  Created by Pradeep Dahiya on 02/12/14.
//  Copyright (c) 2014 Pradeep Dahiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SFCountdownView.h"
#import "Timer.h"
#import <ADTickerLabel/ADTickerLabel.h>
#import "GUAAlertView.h"
#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@class GADBannerView;

@interface Level1ViewController : UIViewController<SFCountdownViewDelegate>{
    
    AppDelegate *appDelegate;
    
    int fristRandomButton;
    int secondRandomButton;
    
    UIButton*btnFrist;
    UIButton*btnSecound;
    
    Timer *objTimer;    //////timer class object
    float timeLableUpdatedValue;
    BOOL btnFirstClicked;
    BOOL btnSecoundClicked;
    BOOL isLevelFailed;
    
    int levelCount;
    int tapCounter;
    int levelTime;
    
    SystemSoundID btnClickSound;
    
    double score;
    
   IBOutlet UILabel *timeLable;
    IBOutlet UILabel *levelNo;
    NSTimer *updateTimer;
    NSTimer *levelTimeUpTimer;
    NSMutableArray *levelTimeUpArray;   ////Used for total level time ////
}

@property(nonatomic, strong) IBOutlet GADBannerView *bannerView;
@property (nonatomic, strong) IBOutlet ADTickerLabel *scoreLable;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (nonatomic, strong) NSMutableArray *btnArray;
@end
