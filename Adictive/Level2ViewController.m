//
//  Level2ViewController.m
//  Adictive
//
//  Created by Pradeep Dahiya on 19/12/14.
//  Copyright (c) 2014 Pradeep Dahiya. All rights reserved.
//

#import "Level2ViewController.h"
#import "OverViewController.h"
#import "GADBannerView.h"
#import "GADRequest.h"
#import "GADBannerViewDelegate.h"
#import "Utility.h"

@interface Level2ViewController ()<GADBannerViewDelegate>

@end

@implementation Level2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    [[Utility sharedInstance] setViewBackGroundImage:@"bg" forView:self];
    //[self setButton];
    UIFont *font = [UIFont boldSystemFontOfSize: 12];
    
    self.scoreLable = [[ADTickerLabel alloc] initWithFrame: CGRectMake(368, 0, 200, font.lineHeight)];
    self.scoreLable.characterWidth = 8;
    self.scoreLable.font = [UIFont boldSystemFontOfSize:12];
    self.scoreLable.textColor=[UIColor whiteColor];
    self.scoreLable.changeTextAnimationDuration = 1.0;
    self.scoreLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.scoreLable];
    
    NSString *btnClickSoundPath = [[NSBundle mainBundle] pathForResource:@"Button Press - Digital 1" ofType:@"wav"];
    NSURL *btnClickSoundPathURL = [NSURL fileURLWithPath:btnClickSoundPath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)btnClickSoundPathURL, &btnClickSound);
    
    self.bannerView.adUnitID = @"ca-app-pub-3489604151361017/2432524683";
    self.bannerView.delegate = self;
    [self.bannerView setRootViewController:self];
    [self setButton];
    [self chkAchivement];
}
-(void)chkAchivement
{
    GKAchievement *achievement= [[GKAchievement alloc] initWithIdentifier:@"add_Advanced"];
    achievement.percentComplete = 100.0;
    if(achievement!= NULL)
    {
        [achievement reportAchievementWithCompletionHandler: ^(NSError *error){
            if(error != nil){
                NSLog(@"Achievement failed");
            } else {
                NSLog(@"Achievement Success");
            }
        }];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    
    NSLog(@" btnArray.count %lu",(unsigned long)self.btnArray.count);
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"HIGH_SCORE"]) ;
    isLevelFailed=NO;
    //objTimer=[[Timer alloc]init];
    boxCount=0;
    subLevelCount=0;
    score=0;
    //self.btnArray=[[NSMutableArray alloc]init];
    //[self screendesign];
    chkOrderArray=nil;
    chkOrderArray=[[NSMutableArray alloc]init];
    
    for (UIView *tbtn in self.view.subviews) {
        if ([tbtn isKindOfClass:[UIButton class]]) {
             tbtn.userInteractionEnabled=NO;
        }
    }
    for (int i=0; i<16; i++) {
        [self settingNilImage:[self.btnArray objectAtIndex:i]];
    }
    levelNo.text=[NSString stringWithFormat:@"stage: %d",subLevelCount+1];
    self.scoreLable.text = nil;
    //[chkOrderArray removeAllObjects];
    [self.bannerView loadRequest:[self createRequest]];
    [self calllevelGenerator];
}
-(void)addWaitImage{
    self.wait=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wait"]];
    self.wait.center=self.view.center;
    [self.view addSubview:self.wait];
}
#pragma mark google adds

- (GADRequest *)createRequest
{
    GADRequest *request = [GADRequest request];
    
    // Make the request for a test ad. Put in an identifier for the simulator as
    // well as any devices you want to receive test ads.
//    request.testDevices =
//    [NSArray arrayWithObjects:@"25b25d30d29890137d356325ec1d6283",
//     // TODO: Add your device/simulator test identifiers here. They are
//     // printed to the console when the app is launched.
//     nil];
    return request;
}
// Called when an ad request loaded an ad.
- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    NSLog(@"adViewDidReceiveAd");
}

/// Called when an ad request failed.
- (void)adView:(GADBannerView *)adView didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"adViewDidFailToReceiveAdWithError: %@", [error localizedDescription]);
}

/// Called just before presenting the user a full screen view, such as
/// a browser, in response to clicking on an ad.
- (void)adViewWillPresentScreen:(GADBannerView *)adView {
    NSLog(@"adViewWillPresentScreen");
}

/// Called just before dismissing a full screen view.
- (void)adViewWillDismissScreen:(GADBannerView *)adView {
    NSLog(@"adViewWillDismissScreen");
}

/// Called just after dismissing a full screen view.
- (void)adViewDidDismissScreen:(GADBannerView *)adView {
    NSLog(@"adViewDidDismissScreen");
}

/// Called just before the application will background or terminate
/// because the user clicked on an ad that will launch another
/// application (such as the App Store).
- (void)adViewWillLeaveApplication:(GADBannerView *)adView {
    NSLog(@"adViewDidLeaveApplication");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setButton{
    
    self.view.userInteractionEnabled=YES;
    self.btnArray=[[NSMutableArray alloc] init];
    for (UIView *btn in self.view.subviews) {
        //[self setButtonColor:btn];
        if ([btn isKindOfClass:[UIButton class]]) {
            [self.btnArray addObject:btn];
            btn.userInteractionEnabled=NO;
            btn.backgroundColor=[UIColor clearColor];
        }
        
       // [btn addTarget:self action:@selector(btn_Clicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    //[self callShowRandomButtons];
}
-(void)calllevelGenerator
{
    [self addWaitImage];
    isLevelFailed=NO;
    [self levelGenerator];
}
-(void)levelGenerator
{
    [self buttonAppears:subLevelCount+1];
}
-(void)buttonAppears:(int)lc
{
    tapCount=lc;
    
    [self performSelector:@selector(buttonsEnable) withObject:nil afterDelay:lc];
    while ([chkOrderArray count]!=lc) {
        fristRandomButton=arc4random()%16;
        if ([chkOrderArray containsObject:[NSNumber numberWithInt:fristRandomButton]])
        {
            fristRandomButton=arc4random()%16;
        }
        else
        {
            [chkOrderArray addObject:[NSNumber numberWithInt:fristRandomButton]];
        }
    }
    for (int i=0; i<lc; i++) {
        btn1=[self.btnArray objectAtIndex:[[chkOrderArray objectAtIndex:i]intValue]];
        [self btn_Appears:btn1 integer:i+1];
    }
}
-(void)buttonsEnable
{
    for (UIButton *tbtn in self.view.subviews) {
        tbtn.userInteractionEnabled=YES;
    }
    [self.wait removeFromSuperview];
    //timeUpTimer=[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(levelTimeUp) userInfo:nil repeats:NO];
}
-(void)btn_Appears:(UIButton *)bt1 integer:(int)it
{
    [self performSelector:@selector(btnShow:) withObject:bt1 afterDelay:it-1];
    [bt1 addTarget:self action:@selector(btn_Clicked:) forControlEvents:UIControlEventTouchUpInside];
    //bt1.showsTouchWhenHighlighted=YES;
    [self performSelector:@selector(hideButton:) withObject:bt1 afterDelay:it];
}
-(void)btnShow:(UIButton*)bt1
{
    //[bt1 setBackgroundImage:[self setImageForAllScreens:appDelegate.strSetButton] forState:UIControlStateNormal];
    [bt1 setBackgroundImage:[UIImage imageNamed:@"setBtn.png"] forState:UIControlStateNormal];
    [bt1 setBackgroundImage:[UIImage imageNamed:@"setBtnNrml"] forState:UIControlStateHighlighted];
}
-(void)hideButton:(UIButton *)btn11
{
    //[btn11 setBackgroundImage:nil forState:UIControlStateNormal];
}
-(void)btn_Clicked:(id)sender
{
//    [timeUpTimer invalidate];
    AppDelegate *appDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    if (appDelegate.soundON) {
        AudioServicesPlaySystemSound(btnClickSound);
    }
    UIButton *bt=(UIButton *)sender;
    bt.highlighted=YES;
    [bt setBackgroundImage:[UIImage imageNamed:@"setBtnNrml"] forState:UIControlStateNormal];
    @try {
        if ([sender tag]==[[chkOrderArray objectAtIndex:orderChk]intValue]) {
            orderChk++;
            if (sucessCount==tapCount-1) {
                for (UIButton *tbtn in self.view.subviews) {
                    tbtn.userInteractionEnabled=NO;
                }
                // [self scoreCalculation];
                subLevelCount++;
                orderChk=0;
                tapCount=0;
                sucessCount=0;
                
                for (int i=0; i<16; i++) {
                    [self settingNilImage:[self.btnArray objectAtIndex:i]];
                }
                int sc=[self scoreCalculation];
                levelNo.text=[NSString stringWithFormat:@"stage: %d",subLevelCount+1];
                self.scoreLable.text = [NSString stringWithFormat:@"%d",1000+sc];
                
                [chkOrderArray removeAllObjects];
                
                
                //            if (appDelegate.soundON) {
                //                [appDelegate.animationMusic1 play];
                //            }
                [self levelClearNotification];
                [self performSelector:@selector(didTapDismissCurrentMessage) withObject:nil afterDelay:1.0];
                [self performSelector:@selector(calllevelGenerator) withObject:nil afterDelay:1.50];
                
            }
            else
            {
                sucessCount++;
                pressCount++;
                int sc=[self scoreCalculation];
                self.scoreLable.text = [NSString stringWithFormat:@"%d",100+sc];
            }
        }
        else
        {
            //[self addOverlayView];
            isLevelFailed=YES;
            AppDelegate *appDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
            score=[self.scoreLable.text doubleValue];
            [self performSegueWithIdentifier:@"over" sender:self];
                    if (appDelegate.soundON) {
                        [appDelegate.levelLoseSound play];
                    }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception.description);
    }
    @finally {
        
    }
    
}
-(double)scoreCalculation
{
    score=(score+100)+(pressCount*5)+(subLevelCount*100);
    return score;
}

- (void)didTapDismissCurrentMessage
{
    [TSMessage dismissActiveNotification];
    //[self performSelector:@selector(setButton) withObject:nil afterDelay:0.5];
}
-(void)levelClearNotification{
    NSString *messageString;
    
    messageString=@"Level Clear";
    
    [TSMessage showNotificationInViewController:self.navigationController
                                          title:NSLocalizedString(@"Adictive!", nil)
                                       subtitle:messageString
                                          image:nil
                                           type:TSMessageNotificationTypeSuccess
                                       duration:TSMessageNotificationDurationAutomatic
                                       callback:nil
                                    buttonTitle:nil
                                 buttonCallback:nil
                                     atPosition:TSMessageNotificationPositionNavBarOverlay
                           canBeDismissedByUser:YES];
}
-(void)settingNilImage:(UIButton *)button
{
    @try {
        [button setBackgroundImage:nil forState:UIControlStateNormal];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception.description);
    }
    @finally {
        
    }
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    OverViewController *destViewController = segue.destinationViewController;
    [destViewController initWithScoreData:score sec:2];

}


@end
