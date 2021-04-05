//
//  Level1ViewController.m
//  Adictive
//
//  Created by Pradeep Dahiya on 02/12/14.
//  Copyright (c) 2014 Pradeep Dahiya. All rights reserved.
//

#import "Level1ViewController.h"
#import "TSMessage.h"
#import "TSMessageView.h"

#import "GADBannerView.h"
#import "GADRequest.h"
#import "GADBannerViewDelegate.h"
#import "OverViewController.h"
#import "Utility.h"

@interface Level1ViewController ()<GADBannerViewDelegate>
{int added;
    int deficulty;}
@property (strong, nonatomic) IBOutlet SFCountdownView *sfCountdownView;
@end

@implementation Level1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *btnClickSoundPath = [[NSBundle mainBundle] pathForResource:@"Button Press - Digital 1" ofType:@"wav"];
    NSURL *btnClickSoundPathURL = [NSURL fileURLWithPath:btnClickSoundPath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)btnClickSoundPathURL, &btnClickSound);
    
    deficulty= (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"DIFICULTY"];
    
    levelTimeUpArray=[[NSMutableArray alloc]init];
    
    switch (deficulty) {
        case 0:
            for (int i=30; i>14; i--) {
                [levelTimeUpArray addObject:[NSNumber numberWithFloat:i]];
            }
            break;
          case 1:
            
            for (int i=30; i>22; i--) {
                [levelTimeUpArray addObject:[NSNumber numberWithFloat:i]];
            }
            for (int i=22; i>14; i-=2) {
                [levelTimeUpArray addObject:[NSNumber numberWithFloat:i]];
            }
            break;
        case 2:
            for (int i=20; i>4; i--) {
                [levelTimeUpArray addObject:[NSNumber numberWithFloat:i]];
            }
            break;
    
        default:
            break;
    }
    
    //self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    [[Utility sharedInstance] setViewBackGroundImage:@"bg" forView:self];
    UIFont *font = [UIFont boldSystemFontOfSize: 12];
    
    self.scoreLable = [[ADTickerLabel alloc] initWithFrame: CGRectMake(234, 0, 100, font.lineHeight)];
    self.scoreLable.font = font;
    self.scoreLable.characterWidth = 8;
    self.scoreLable.textColor=[UIColor whiteColor];
    self.scoreLable.changeTextAnimationDuration = 1.0;
    self.scoreLable.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:self.scoreLable];
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.width >= 568) {
        //added=88;
    }
    else{
        added=88;
    }
    
    NSLog(@"%@",levelTimeUpArray);
}

-(void)startCountdown{
    
    self.sfCountdownView.delegate = self;
    self.sfCountdownView.backgroundAlpha = 0.2;
    self.sfCountdownView.countdownColor = [UIColor whiteColor];
    self.sfCountdownView.countdownFrom = 3;
    self.sfCountdownView.finishText = @"Do it";
    [self.sfCountdownView updateAppearance];
}
- (void) viewDidAppear:(BOOL)animated
{
    [self.sfCountdownView start];
}
-(void)viewWillAppear:(BOOL)animated{
    
    
    [self startCountdown];
    objTimer=[[Timer alloc]init];
    levelCount=0;
    score=0;
}
- (void) countdownFinished:(SFCountdownView *)view
{
    [self.sfCountdownView removeFromSuperview];
    [self.view setNeedsDisplay];
    self.bannerView.adUnitID = @"ca-app-pub-3489604151361017/2432524683";
    self.bannerView.delegate = self;
    [self.bannerView setRootViewController:self];
    [self.bannerView loadRequest:[self createRequest]];
    
    [self setButton];
}
-(void)setButton{
    self.view.userInteractionEnabled=YES;
    self.btnArray=[[NSMutableArray alloc] init];
    for (UIButton *btn in self.view.subviews) {
        //[self setButtonColor:btn];
        [self.btnArray addObject:btn];
        btn.userInteractionEnabled=NO;
        btn.backgroundColor=[UIColor clearColor];
    }
    [self callShowRandomButtons];
}
-(void)setButtonColor:(UIButton *)btn{
    
    CGFloat redLevel    = rand() / (float) RAND_MAX;
    CGFloat greenLevel  = rand() / (float) RAND_MAX;
    CGFloat blueLevel   = rand() / (float) RAND_MAX;
    
    
        btn.backgroundColor=[UIColor colorWithRed: redLevel
                                            green: greenLevel
                                             blue: blueLevel
                                            alpha: 1.0];

}
-(void)setButtonImage:(UIButton *)bt1{
    [bt1 setBackgroundImage:[UIImage imageNamed:@"setBtn.png"] forState:UIControlStateNormal];
}
-(void)setButtonImageClicked:(UIButton *)bt1{
    [bt1 setBackgroundImage:[UIImage imageNamed:@"setBtnNrml.png"] forState:UIControlStateNormal];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)callShowRandomButtons
{
    
    [objTimer startTimer];
    isLevelFailed=NO;
    [self genetateNextPairOfButtons];
    [self showLevelTimeLable];
    levelTimeUpTimer=[NSTimer scheduledTimerWithTimeInterval:[[levelTimeUpArray objectAtIndex:levelCount]floatValue ] target:self selector:@selector(levelTimeUp) userInfo:nil repeats:NO];
  //  beepTimer=[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(playTimerBeeps) userInfo:nil repeats:YES];
}
-(void)levelTimeUp
{
    [objTimer stopTimer];
    [updateTimer invalidate];
    NSLog(@"Time UP: %d seconds", [objTimer timeElapsedInSeconds]);
    [btnFrist setBackgroundImage:nil forState:UIControlStateNormal];
    [btnSecound setBackgroundImage:nil forState:UIControlStateNormal];
    btnSecoundClicked=NO;
    btnFirstClicked=NO;
    tapCounter=0;

    if (appDelegate.soundON) {
        [appDelegate.levelLoseSound play];
    }
    
    btnSecound.userInteractionEnabled=NO;
    btnFrist.userInteractionEnabled=NO;
    isLevelFailed=YES;
    score=[self.scoreLable.text doubleValue];
    self.scoreLable.text=nil;
    [self performSegueWithIdentifier:@"over" sender:self];
}

-(void)genetateNextPairOfButtons
{
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    fristRandomButton=arc4random()%16;
    secondRandomButton=arc4random()%16;
    if (fristRandomButton==secondRandomButton) {
        secondRandomButton=arc4random()%(16);
        if (fristRandomButton==secondRandomButton) {
            secondRandomButton=arc4random()%(16);
        }
    }
    btnFrist=nil;
    btnFrist=[self.btnArray objectAtIndex:fristRandomButton];
    btnSecound=nil;
    btnSecound=[self.btnArray objectAtIndex:secondRandomButton];
    btnFrist.tag=101;
    btnSecound.tag=102;
   // [self setButtonColor:btnFrist];
   // [self setButtonColor:btnSecound];
    [self setButtonImage:btnFrist];
    [self setButtonImage:btnSecound];
    btnFrist.userInteractionEnabled=YES;
    [btnFrist addTarget:self action:@selector(btn_Clicked:) forControlEvents:UIControlEventTouchUpInside];
    
    btnSecound.userInteractionEnabled=YES;
    [btnSecound addTarget:self action:@selector(btn_Clicked:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)showLevelTimeLable
{
    timeLable.text=[NSString stringWithFormat:@"%@",[levelTimeUpArray objectAtIndex:levelCount]];
    levelNo.text=[NSString stringWithFormat:@"Level: %d",levelCount];
    timeLableUpdatedValue=[[levelTimeUpArray objectAtIndex:levelCount]floatValue ];
    updateTimer=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
}
-(void)updateTime
{
    [timeLable setText:[NSString stringWithFormat:@"%.1f",timeLable.text.floatValue-0.1]];
}
-(void)btn_Clicked:(id)sender
{
    if (appDelegate.isMusicOn) {
        AudioServicesPlaySystemSound(btnClickSound);
    }
    if ([sender tag]==101) {
        btnFrist.userInteractionEnabled=NO;
        [self setButtonImageClicked:sender];
        btnFirstClicked=YES;
        [self buttonsTapped];
    }
    if ([sender tag]==102) {
        btnSecound.userInteractionEnabled=NO;
        btnSecoundClicked=YES;
        [self setButtonImageClicked:sender];
        [self buttonsTapped];
    }
}
-(double)scoreCalculation
{
    
    int variable = 0;
    switch (deficulty) {
        case 0:
            variable=10*levelTime;
            break;
         case 1:
            variable=50*levelTime;
            break;
            case 2:
            if (levelCount>7) {
                variable=100*levelTime;
            }
            else{
                variable=70*levelTime;
            }
            break;
        default:
            break;
    }
    NSLog(@"variable %d",variable);
    switch (tapCounter) {
        case 0:
            score=10;
            break;
        case 1:
            score=score+variable+10;
            break;
        case 2:
            score=score+variable+20;
            break;
        case 3:
            score=score+variable+30;
            break;
        case 4:
            score=score+variable+50;
            break;
        case 5:
            score=score+variable+70;
            break;
        case 6:
            score=score+variable+90;
            break;
        case 7:
            score=score+variable+100;
            break;
        case 8:
            score=score+variable+130;
            break;
        case 9:
            score=score+variable+140;
            break;
        case 10:
            score=score+variable+150;
            break;
            
        default:
            break;
    }
    //int addedValue=[[levelTimeUpArray objectAtIndex:levelCount] intValue]-levelTime;
   // score=score+addedValue;
    
//    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"HIGH_SCORE"] intValue]<score)
//    {
//        [[NSUserDefaults standardUserDefaults] setInteger:score forKey:@"HIGH_SCORE"];
//    }
    return score;
}
-(void)buttonsTapped
{
    if ((btnSecoundClicked==YES) && (btnFirstClicked==YES))
    {
        
            btnSecoundClicked=NO;
            btnFirstClicked=NO;
        [btnFrist setBackgroundImage:nil forState:UIControlStateNormal];
        [btnSecound setBackgroundImage:nil forState:UIControlStateNormal];
            btnSecound.userInteractionEnabled=NO;
            btnFrist.userInteractionEnabled=NO;
            btnFrist=nil;
            btnSecound=nil;
            tapCounter++;
        
        int sc=[self scoreCalculation];
        self.scoreLable.text = [NSString stringWithFormat:@"%d",100+sc];

        if(levelCount==15&& tapCounter==10)  //Executes if tap counts are not equal to 10
        {
            [self levelTimeUp];
            return;
        }
            if (tapCounter==10) {   //Check for bonus counts
                tapCounter=0;
                [objTimer stopTimer];
                [updateTimer invalidate];
                [levelTimeUpTimer invalidate];
                NSLog(@"Completed Level Time : %d seconds", [objTimer timeElapsedInSeconds]);
                levelTime=[objTimer timeElapsedInSeconds];
                levelTime=[[levelTimeUpArray objectAtIndex:levelCount] intValue]-levelTime;
                //int sc=[self scoreCalculation];
               // self.scoreLable.text = [NSString stringWithFormat:@"%d",100+sc];
                levelCount++;
                //levelTime=0;
                [self levelClearNotification];
                [self performSelector:@selector(didTapDismissCurrentMessage) withObject:nil afterDelay:1.0];
                    //Executes if not a bonus level
                
                    self.view.userInteractionEnabled=NO;
                   // animationTimer = [NSTimer scheduledTimerWithTimeInterval: 0.1 target: self
                                                                   // selector: @selector(levelCompleted) userInfo: nil repeats: YES];
//                    if (appDelegate.soundON) {
//                        [appDelegate.animationMusic1 prepareToPlay];
//                        [appDelegate.animationMusic1 play];
//                    }
                if (levelCount==5 || levelCount==8 || levelCount==14) {
                    [self chkAchivementforlevel:levelCount];
                }
                
                if (levelCount==6 && [objTimer timeElapsedInSeconds]<7) {
                    
                    GKAchievement *achievement= [[GKAchievement alloc] initWithIdentifier:@"The_Practicing_Thinker"] ;
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
                }///end of achivmnt if cndition
                
                if (levelCount==11 && [objTimer timeElapsedInSeconds]<5) {
                    
                    GKAchievement *achievement= [[GKAchievement alloc] initWithIdentifier:@"The_Advanced_Thinker"];
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
                }///end of achivmnt if cndition
                
            }
            else if(levelCount==15&& tapCounter==10)  //Executes if tap counts are not equal to 10
            {
                [self levelTimeUp];
                return;
            }
        else
        {
        [self genetateNextPairOfButtons];
        }
    }
}
-(void)chkAchivementforlevel:(int)level
{
    GKAchievement *achievement;
    switch (level) {
        case 5:
            achievement= [[GKAchievement alloc] initWithIdentifier:@"add_unreflective"];
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
            break;
            case 8:
            achievement= [[GKAchievement alloc] initWithIdentifier:@"add_Challenged"];
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
            break;
            case 14:
            achievement= [[GKAchievement alloc] initWithIdentifier:@"add_Accomplished"];
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
            break;
        default:
            break;
    }
}
- (void)didTapDismissCurrentMessage
{
    [TSMessage dismissActiveNotification];
    [self performSelector:@selector(setButton) withObject:nil afterDelay:0.5];
}

-(IBAction)backPressed:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark google adds 

- (GADRequest *)createRequest
{
    GADRequest *request = [GADRequest request];
    
    // Make the request for a test ad. Put in an identifier for the simulator as
    // well as any devices you want to receive test ads.
   // request.testDevices =
    [NSArray arrayWithObjects:GAD_SIMULATOR_ID,
     // TODO: Add your device/simulator test identifiers here. They are
     // printed to the console when the app is launched.
     nil];
    return request;
}
// Called when an ad request loaded an ad.
- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    NSLog(@"adViewDidReceiveAd");
}

/// Called when an ad request failed.
- (void)adView:(GADBannerView *)adView didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"adViewDidFailToReceiveAdWithError: %@", [error localizedFailureReason]);
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    OverViewController *destViewController = segue.destinationViewController;
    [destViewController initWithScoreData:score sec:17];
}


@end
