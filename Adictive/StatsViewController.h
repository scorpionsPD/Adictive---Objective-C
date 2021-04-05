//
//  StatsViewController.h
//  Adictive
//
//  Created by Pradeep Dahiya on 31/12/14.
//  Copyright (c) 2014 Pradeep Dahiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
@interface StatsViewController : UIViewController<GKGameCenterControllerDelegate>
{
    NSMutableArray *playersFriends;
    //NSMutableArray *friendsIDs;
    NSMutableArray *retrievePlayerScores;
    NSString *lederboardCategory;
    
   IBOutlet UILabel *score1;
   IBOutlet UILabel *score2;
   IBOutlet UILabel *score3;
   IBOutlet UILabel *score4;
    
   IBOutlet UILabel *name1;
   IBOutlet UILabel *name2;
   IBOutlet UILabel *name3;
   IBOutlet UILabel *name4;
    
    IBOutlet UILabel *highScore;
    IBOutlet UILabel *coinsLable;
}
@end
