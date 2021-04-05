//
//  AppDelegate.m
//  Adictive
//
//  Created by Pradeep Dahiya on 19/11/14.
//  Copyright (c) 2014 Pradeep Dahiya. All rights reserved.
//
#include <sys/types.h>
#include <sys/sysctl.h>

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark -
#pragma mark Game Center Support

@synthesize currentPlayerID,
gameCenterAuthenticationComplete;



#pragma mark -
#pragma mark Game Center Support

// Check for the availability of Game Center API.
BOOL isGameCenterAPIAvailable()
{
    // Check for presence of GKLocalPlayer API.
    Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
    
    // The device must be running running iOS 4.1 or later.
    NSString *reqSysVer = @"4.1";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending);
    
    return (gcClass && osVersionSupported);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [UIApplication sharedApplication].statusBarHidden=YES;
    
    self.gameCenterAuthenticationComplete = NO;
    
    if (!isGameCenterAPIAvailable()) {
        // Game Center is not available.
        self.gameCenterAuthenticationComplete = NO;
    } else {
        
        GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
        
        [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:^(NSError *error) {
            // If there is an error, do not assume local player is not authenticated.
            if (localPlayer.isAuthenticated) {
                
                // Enable Game Center Functionality
                self.gameCenterAuthenticationComplete = YES;
                
                if (! self.currentPlayerID || ! [self.currentPlayerID isEqualToString:localPlayer.playerID]) {
                    
                    // Current playerID has changed. Create/Load a game state around the new user.
                    self.currentPlayerID = localPlayer.playerID;
                    
                    // Load game instance for new current player, if none exists create a new.
                }
            } else {
                // No user is logged into Game Center, run without Game Center support or user interface.
                self.gameCenterAuthenticationComplete = NO;
            }
        }];
    }
    [self functionForBackgroungAudio];
    return YES;
}
-(void)functionForBackgroungAudio
{
    NSError *setCategoryError = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:&setCategoryError];
    
    // Create audio player with background music
    
    NSString *levelLoseSoundPathFile = [[NSBundle mainBundle] pathForResource:@"GAME OVER  1" ofType:@"wav"];
    NSURL *levelLoseSoundPathFile1URL = [NSURL fileURLWithPath:levelLoseSoundPathFile];
    NSError *error;
    self.levelLoseSound = [[AVAudioPlayer alloc] initWithContentsOfURL:levelLoseSoundPathFile1URL error:&error];
    
    [self.levelLoseSound setDelegate:self];  // We need this so we can restart after interruptions
    [self.levelLoseSound setNumberOfLoops:0];	// 0 number means loop once
    self.levelLoseSound.volume=0.3;
    
    self.soundON=YES;

}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    self.gameCenterAuthenticationComplete = NO;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
