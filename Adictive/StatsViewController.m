//
//  StatsViewController.m
//  Adictive
//
//  Created by Pradeep Dahiya on 31/12/14.
//  Copyright (c) 2014 Pradeep Dahiya. All rights reserved.
//

#import "StatsViewController.h"
#import "Utility.h"

@interface StatsViewController ()

@end

@implementation StatsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden=YES;
        lederboardCategory=@"Addictive_FootSteps";
    //self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgg.png"]];
    [[Utility sharedInstance] setViewBackGroundImage:@"bgg" forView:self];
    int highScoree=[[[NSUserDefaults standardUserDefaults] valueForKey:@"HIGH_SCORE"] intValue];
    int coins=[[[NSUserDefaults standardUserDefaults] valueForKey:@"COINS"] intValue];
    coinsLable.text=[NSString stringWithFormat:@"%d",coins];
    highScore.text=[NSString stringWithFormat:@"%d",highScoree];
    [self getScoresAndAliasForLeaderboard:nil];
}
-(IBAction)dismisss:(id)sender{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
///GEtting players score and Name...

-(void)getScoresAndAliasForLeaderboard:(GKLeaderboard *)leaderboardRequest{
    if (leaderboardRequest == nil)
    {
        leaderboardRequest = [[GKLeaderboard alloc] init];
        leaderboardRequest.playerScope = GKLeaderboardPlayerScopeFriendsOnly;
        leaderboardRequest.timeScope = GKLeaderboardTimeScopeAllTime;
        leaderboardRequest.identifier = lederboardCategory;
        leaderboardRequest.range = NSMakeRange(1,100);
    }
    
    [leaderboardRequest loadScoresWithCompletionHandler: ^(NSArray *scores, NSError *error) {
        if (error != nil)
        {
            // Handle the error.
            NSLog(@"%@",error);
        }
        retrievePlayerScores = [[NSMutableArray alloc] init];
        NSMutableArray *friendsIDs=[NSMutableArray new];
        NSLog(@"scores=%@",scores);
        if (scores != nil)
        {
            for (GKScore *s in scores)
            {
                [retrievePlayerScores addObject:[NSString stringWithFormat:@"%lld",s.value]];
                [friendsIDs addObject:s.playerID];
                
                NSLog(@"retrievePlayerIDs=%@",retrievePlayerScores);
            }
            [self loadPlayerData:friendsIDs];
        }
    }];
    
}

- (void) loadPlayerData: (NSArray *) identifiers
{
    [GKPlayer loadPlayersForIdentifiers:identifiers withCompletionHandler:^(NSArray *players, NSError *error) {
        if (error != nil)
        {
            // Handle the error.
        }
        if (players != nil)
        {
            // Process the array of GKPlayer objects.
            playersFriends=[NSMutableArray new];
            
            for (GKPlayer *plr in players){
                NSString *str=plr.alias;
                [playersFriends addObject:str];
            }
            NSLog(@"players=%@",playersFriends);
        }
    }];
    [self loadFriendsData];
}
-(void)loadFriendsData
{
    int arraySize;
    arraySize=(int)[playersFriends count];
    if (arraySize>0) {
        score1.text=[retrievePlayerScores objectAtIndex:0];
        name1.text=[playersFriends objectAtIndex:0];
    }
    else
    {
        score1.text=nil;
        name1.text=nil;
    }
    if (arraySize>1) {
        score2.text=[retrievePlayerScores objectAtIndex:1];
        name2.text=[playersFriends objectAtIndex:1];
    }
    else
    {
        score2.text=nil;
        name2.text=nil;
    }
    
    if (arraySize>2) {
        score3.text=[retrievePlayerScores objectAtIndex:2];
        name3.text=[playersFriends objectAtIndex:2];
    }
    else
    {
        score3.text=nil;
        name3.text=nil;
    }
    
    if (arraySize>3) {
        score4.text=[retrievePlayerScores objectAtIndex:3];
        name4.text=[playersFriends objectAtIndex:3];
    }
    else
    {
        score4.text=nil;
        name4.text=nil;
    }
}
- (IBAction)showLeaderboard
{
    GKGameCenterViewController *gameCenterController = [[GKGameCenterViewController alloc] init];
    if (gameCenterController != nil)
    {
        gameCenterController.gameCenterDelegate = self;
        gameCenterController.viewState = GKGameCenterViewControllerStateLeaderboards;
        gameCenterController.leaderboardTimeScope = GKLeaderboardTimeScopeToday;
        //gameCenterController.leaderboardCategory = nil;
        [self presentViewController: gameCenterController animated: YES completion:nil];
    }
}
- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
