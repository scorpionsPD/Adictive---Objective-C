//
//  OverViewController.m
//  Adictive
//
//  Created by Pradeep Dahiya on 16/12/14.
//  Copyright (c) 2014 Pradeep Dahiya. All rights reserved.
//

#import "OverViewController.h"
#import "Utility.h"

@interface OverViewController ()
{
    int added;
}
@end

@implementation OverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    [[Utility sharedInstance] setViewBackGroundImage:@"bg" forView:self];
    [self loadSlider];
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    if (screenBounds.size.width >= 568) {
        //added=88;
    }
    else{
    added=88;
    }
    // Do any additional setup after loading the view.
}
-(void)initWithScoreData:(double)score sec:(int)sec{
    self.score=score;
    second=sec;
    if (sec==2) {
        lederboardCategory=@"Addictive_FootSteps";
    }
    else
        lederboardCategory=@"addictive_tap";
}
-(void)viewWillAppear:(BOOL)animated{
    UIFont *font = [UIFont boldSystemFontOfSize: 30];
    
    self.scoreLable = [[ADTickerLabel alloc] initWithFrame: CGRectMake(390-added, 57, 162, font.lineHeight)];
    self.scoreLable.font = font;
    self.scoreLable.characterWidth = 18;
    self.scoreLable.textColor=[UIColor whiteColor];
    self.scoreLable.changeTextAnimationDuration = 1.0;
    self.scoreLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.scoreLable];
    
    self.timeBonus = [[ADTickerLabel alloc] initWithFrame: CGRectMake(437-added, 105, 110, font.lineHeight)];
    self.timeBonus.font = font;
    self.timeBonus.characterWidth = 18;
    self.timeBonus.textColor=[UIColor whiteColor];
    self.timeBonus.changeTextAnimationDuration = 1.0;
    self.timeBonus.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.timeBonus];
    
    self.total = [[ADTickerLabel alloc] initWithFrame: CGRectMake(397-added, 124, 110, font.lineHeight)];
    self.total.font = font;
    self.total.characterWidth = 18;
    self.total.textColor=[UIColor whiteColor];
    self.total.changeTextAnimationDuration = 1.0;
    self.total.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.total];
    [self setScoreVale];
    [self performSelector:@selector(setBonusValue) withObject:nil afterDelay:1.5];
    [self performSelector:@selector(setTotalValue) withObject:nil afterDelay:2.5];
    
    NSLog(@"%f",self.score);
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"HIGH_SCORE"] intValue]<self.score)
    {
        [[NSUserDefaults standardUserDefaults] setInteger:self.score forKey:@"HIGH_SCORE"];
    }
    [self submitMyScore];
}
-(void)setScoreVale{
    self.scoreLable.text=[NSString stringWithFormat:@"%d",(int)self.score];
}
-(void)setBonusValue{
    
    int coin=[[[NSUserDefaults standardUserDefaults] valueForKey:@"COINS"] intValue];
    
    int coins=self.score/16;
    coin=coin+coins;
    [self chkAchivementforlevel:coin];
    [[NSUserDefaults standardUserDefaults] setInteger:coin forKey:@"COINS"];
    self.timeBonus.text=[NSString stringWithFormat:@"%d",(int)coins];
}
-(void)chkAchivementforlevel:(int)score
{
    GKAchievement *achievement;
    
    if (score>5000) {
        achievement= [[GKAchievement alloc] initWithIdentifier:@"add_faster"];
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
    if (score>10000) {
        achievement= [[GKAchievement alloc] initWithIdentifier:@"add_steady_finger"];
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
    if (score>20000) {
        achievement= [[GKAchievement alloc] initWithIdentifier:@"add_damon_finger"];
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
}
-(void)setTotalValue{

    //int total=second+self.score;
    //self.total.text=[NSString stringWithFormat:@"%d",(int)total];
}
-(IBAction)restart:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)home:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showLeaderboardButtonAction:(id)event
{
    NSString * leaderboardCategory = lederboardCategory;
    // The intent here is to show the leaderboard and then submit a score. If we try to submit the score first there is no guarentee
    // the server will have recieved the score when retreiving the current list
    [self showLeaderboard:leaderboardCategory];
    //[self insertCurrentTimeIntoLeaderboard:leaderboardCategory];
}

// Example of how to bring up a specific leaderboard
- (void) showLeaderboard: (NSString*) leaderboardID
{
    GKGameCenterViewController *gameCenterController = [[GKGameCenterViewController alloc] init];
    if (gameCenterController != nil)
    {
        gameCenterController.gameCenterDelegate = self;
        gameCenterController.viewState = GKGameCenterViewControllerStateLeaderboards;
        gameCenterController.leaderboardTimeScope = GKLeaderboardTimeScopeAllTime;
        gameCenterController.leaderboardCategory = leaderboardID;
        [self presentViewController: gameCenterController animated: YES completion:nil];
    }
    
   // [self getScoresAndAliasForLeaderboard:nil];
    // [self retrieveFriends];
}
- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -
#pragma mark  Game Center Integration Methods

-(void)submitMyScore{
    //This is the same category id you set in your itunes connect GameCenter LeaderBoard
    GKScore *myScoreValue = [[GKScore alloc] initWithLeaderboardIdentifier:lederboardCategory];
    myScoreValue.value = self.score;
    
    [myScoreValue reportScoreWithCompletionHandler:^(NSError *error){
        if(error != nil){
            NSLog(@"Score Submission Failed");
        } else {
            NSLog(@"Score Submitted");
        }
        
    }];
    
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"TOTAL_COINS"] intValue]>=25000){
        GKAchievement *achievement= [[GKAchievement alloc] initWithIdentifier:@"Million_Club"] ;
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
    
    
//    if (levelChk==1) {
//        [self checkAchievements];
//    }
//    else
//    {
//        [self checkAchievementsForLevel2];
//    }
    
}

-(void)loadSlider{
    UIView *twitterItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [twitterItem setMenuActionWithBlock:^{
        NSLog(@"tapped twitter item");
        [self btnTwitter_clicked];
    }];
    UIImageView *twitterIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [twitterIcon setImage:[UIImage imageNamed:@"twitter"]];
    [twitterItem addSubview:twitterIcon];
    
    UIView *emailItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [emailItem setMenuActionWithBlock:^{
        NSLog(@"tapped email item");
        [self btnShare_clicked];
    }];
    UIImageView *emailIcon = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 30 , 30)];
    [emailIcon setImage:[UIImage imageNamed:@"email"]];
    [emailItem addSubview:emailIcon];
    
    UIView *facebookItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [facebookItem setMenuActionWithBlock:^{
        [self btnFacebook_clicked];
    }];
    UIImageView *facebookIcon = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 35, 35)];
    [facebookIcon setImage:[UIImage imageNamed:@"facebook"]];
    [facebookItem addSubview:facebookIcon];
    
    UIView *browserItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [browserItem setMenuActionWithBlock:^{
        NSLog(@"tapped browser item");
    }];
    UIImageView *browserIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [browserIcon setImage:[UIImage imageNamed:@"browser"]];
    [browserItem addSubview:browserIcon];
    
    self.sideMenu = [[HMSideMenu alloc] initWithItems:@[twitterItem, emailItem, facebookItem]];
    [self.sideMenu setItemSpacing:5.0f];
    [self.view addSubview:self.sideMenu];
}
- (IBAction)toggleMenu:(id)sender {
    if (self.sideMenu.isOpen)
        [self.sideMenu close];
    else
        [self.sideMenu open];
}

#pragma mark Sharing Methods

-(void)btnFacebook_clicked {
    
    SLComposeViewController *fbVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    
    [fbVC setInitialText:[NSString stringWithFormat:@"I just scored %d points while playing Addictive",(int)self.score/16]];
    
    [fbVC addImage:[UIImage imageNamed:@"shareImage"]];
    
    [self presentViewController:fbVC animated:YES completion:nil];
}

-(void)btnTwitter_clicked {
    
    SLComposeViewController *twitterVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    
    [twitterVC setInitialText:[NSString stringWithFormat:@"I just scored %d points while playing Addictive",(int)self.score/16]];
    
    [twitterVC addImage:[UIImage imageNamed:@"shareImage"]];
    
    [self presentViewController:twitterVC animated:YES completion:nil];
}
-(void)btnShare_clicked{
    
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailComposer;
        mailComposer  = [[MFMailComposeViewController alloc] init];
        mailComposer.mailComposeDelegate = self;
        [mailComposer setModalPresentationStyle:UIModalPresentationFormSheet];
        [mailComposer setSubject:@"Feedback of addictive - iPhone App"];
       
        NSArray *toRecipients = [NSArray arrayWithObject:@"info@maassstechnologies.com"];
        [mailComposer setToRecipients:toRecipients];
        [self presentViewController:mailComposer animated:YES completion:nil];
    }
}
- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error
{
    if(error) NSLog(@"ERROR - mailComposeController: %@", [error localizedDescription]);
    [self dismissViewControllerAnimated:YES completion:nil];
    return;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
