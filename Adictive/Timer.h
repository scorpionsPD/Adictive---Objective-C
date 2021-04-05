//
//  Timer.h
//  ThinkFast
//
//  Created by infoface  on 01/08/13.
//  Copyright (c) 2013 infoface . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Timer : NSObject
{
    NSDate *start;
    NSDate *end;
}
- (void) startTimer;

- (void) stopTimer;

- (int) timeElapsedInSeconds;

- (double) timeElapsedInMilliseconds;

- (double) timeElapsedInMinutes;

@end
