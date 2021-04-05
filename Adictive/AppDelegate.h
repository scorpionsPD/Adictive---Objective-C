//
//  AppDelegate.h
//  Adictive
//
//  Created by Pradeep Dahiya on 19/11/14.
//  Copyright (c) 2014 Pradeep Dahiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
// Preferred method for testing for Game Center
BOOL isGameCenterAvailable();

@interface AppDelegate : UIResponder <UIApplicationDelegate,AVAudioPlayerDelegate>

@property (strong, nonatomic) UIWindow *window;

// currentPlayerID is the value of the playerID last time GameKit authenticated.
@property (retain,readwrite) NSString * currentPlayerID;

@property(nonatomic) BOOL soundON;

@property(nonatomic) BOOL isMusicOn;

@property(nonatomic,strong) AVAudioPlayer *_backgroundMusicPlayer;

@property(nonatomic,strong) AVAudioPlayer *levelLoseSound;

@property(nonatomic,strong) AVAudioPlayer *animationMusic1;

@property(nonatomic,strong) AVAudioPlayer *animationMusic2;

@property(nonatomic,strong) AVAudioPlayer *buttonPressSound;

@property(nonatomic) BOOL _backgroundMusicPlaying;
// isGameCenterAuthenticationComplete is set after authentication, and authenticateWithCompletionHandler's completionHandler block has been run. It is unset when the applicaiton is backgrounded.
@property (readwrite, getter=isGameCenterAuthenticationComplete) BOOL gameCenterAuthenticationComplete;

@end

