//
//  Utility.h
//  Adictive
//
//  Created by Pradeep Dahiya on 02/01/15.
//  Copyright (c) 2015 Pradeep Dahiya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Utility : NSObject
@property(nonatomic) int dificultyLevel;
@property (nonatomic, strong, readwrite)UIViewController *viewController;
+ (Utility *)sharedInstance;
-(void)setViewBackGroundImage:(NSString *)bgImage forView:(UIViewController *)controller;
@end
