//
//  Utility.m
//  Adictive
//
//  Created by Pradeep Dahiya on 02/01/15.
//  Copyright (c) 2015 Pradeep Dahiya. All rights reserved.
//

#import "Utility.h"

@implementation Utility
static Utility *_global;

+ (Utility *)sharedInstance
{
    @synchronized(self)
    {
        if (_global == nil)
            _global=[[self alloc] init];
    }
    return _global;
}
-(void)setViewBackGroundImage:(NSString *)bgImage forView:(UIViewController *)controller {
    
    self.viewController=controller;
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    if (screenBounds.size.width >= 568) {
        self.viewController.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-568h.png",bgImage]]];
        NSLog(@"%@",[NSString stringWithFormat:@"%@-568h.png",bgImage]);
    } else {
        self.viewController.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",bgImage]]];
    }
}
@end
