//
//  MenuViewController.m
//  Adictive
//
//  Created by Pradeep Dahiya on 02/12/14.
//  Copyright (c) 2014 Pradeep Dahiya. All rights reserved.
//

#import "MenuViewController.h"
#import "Level1ViewController.h"
#import "MTAnimatedLabel.h"
#import "Utility.h"
#define kMaxTranslation 190.0f

@interface MenuViewController ()
{
CGFloat sliderInitialX;
}
@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.automaticallyAdjustsScrollViewInsets=NO;
    //self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    [[Utility sharedInstance] setViewBackGroundImage:@"bg" forView:self];
    [self createAndLoadInterstitial];
    [self performSelector:@selector(show_Add) withObject:nil afterDelay:3];
    apdelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
   // [self startMusic];
    apdelegate.isMusicOn=YES;
    isSoundOn=YES;
    
}
- (void)stopMusic
{
    [apdelegate._backgroundMusicPlayer stop];
}
- (void)startMusic
{
    [apdelegate._backgroundMusicPlayer prepareToPlay];
    [apdelegate._backgroundMusicPlayer play];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)playClicked:(id)sender{
    UIButton *btn=(UIButton*)sender;
    int coin=[[[NSUserDefaults standardUserDefaults] valueForKey:@"COINS"] intValue];
    switch (btn.tag) {
        case 1:
            [self performSegueWithIdentifier:@"level1" sender:self];
            break;
          case 2:
            if (coin<13000) {
                //[self performSegueWithIdentifier:@"NotEligible" sender:self];
                [self performSegueWithIdentifier:@"level2" sender:self];
                break;
            }
            [self performSegueWithIdentifier:@"level2" sender:self];
            break;
        default:
            break;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.animatedLabel startAnimating];
    [self.animatedLabel1 startAnimating];
    
    
}
-(void)show_Add{
    if (self.interstitial.isReady) {
        [self.interstitial presentFromRootViewController:self];
    }

}
- (void)createAndLoadInterstitial {
    self.interstitial = [[GADInterstitial alloc] init];
    self.interstitial.adUnitID = @"ca-app-pub-3489604151361017/2432524683";
    self.interstitial.delegate = self;
    
    GADRequest *request = [GADRequest request];
    // Request test ads on devices you specify. Your test device ID is printed to the console when
    // an ad request is made.
    request.testDevices = @[ GAD_SIMULATOR_ID, @"MY_TEST_DEVICE_ID" ];
    [self.interstitial loadRequest:request];
    
}

-(IBAction)instruction:(id)sender{
    GUAAlertView *v = [GUAAlertView alertViewWithTitle:@"Instruction"
                                               message:@"There are two buttons will come simultaneously tap on there as much as fast you can .\n Tap on 10 pairs with in time limit that will be considered as a stage cleared "
                                           buttonTitle:@"ok"
                                   buttonTouchedAction:^{
                                       NSLog(@"button touched");
                                   } dismissAction:^{
                                       NSLog(@"dismiss");
                                   }];
    [v show];
}
-(IBAction)instruction1:(id)sender{
    GUAAlertView *v = [GUAAlertView alertViewWithTitle:@"Instruction"
                                               message:@"Tap on buttons in the same sequence in which they were apeared .\n No time limit but any wrong order press will lose the game"
                                           buttonTitle:@"ok"
                                   buttonTouchedAction:^{
                                       NSLog(@"button touched");
                                   } dismissAction:^{
                                       NSLog(@"dismiss");
                                   }];
    [v show];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.animatedLabel stopAnimating];
    
}

- (void)viewDidUnload
{
    [self setAnimatedLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = self.scroolView.frame.size.width;
    float fractionalPage = self.scroolView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    self.pageControl.currentPage = page;
}
-(IBAction)backPressed:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark GADInterstitialDelegate implementation

- (void)interstitial:(GADInterstitial *)interstitial
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"interstitialDidFailToReceiveAdWithError: %@", [error localizedDescription]);
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial {
    NSLog(@"interstitialDidDismissScreen");
}
-(IBAction)btn_Music_Clicked:(id)sender
{
    
}
- (IBAction)soundClicked:(id)sender {
    if (isSoundOn)
    {
        [sender setImage:[UIImage imageNamed:@"sOFF.png"] forState:UIControlStateNormal];
        apdelegate.soundON=NO;
        [self stopMusic];
    }
    else
    {
        [sender setImage:[UIImage imageNamed:@"sON.png"] forState:UIControlStateNormal];
        apdelegate.soundON=YES;
        [self startMusic];
    }
    isSoundOn=!isSoundOn;

}
- (IBAction)musicClicked:(id)sender {
    
    if (apdelegate.isMusicOn) {
        apdelegate._backgroundMusicPlaying=NO;
        [sender setImage:[UIImage imageNamed:@"mOFF.png"] forState:UIControlStateNormal];
    }
    else
    {
        apdelegate._backgroundMusicPlaying=YES;
        [sender setImage:[UIImage imageNamed:@"mON.png"] forState:UIControlStateNormal];
    }
    apdelegate.isMusicOn=!apdelegate.isMusicOn;
}

-(void)viewDidDisappear:(BOOL)animated{
    [self stopMusic];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"over"]) {
//        Level1ViewController *destViewController = segue.destinationViewController;
//    }
}


@end
