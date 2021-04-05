//
//  Timer.m
//  ThinkFast
//
//  Created by infoface  on 01/08/13.
//  Copyright (c) 2013 infoface . All rights reserved.
//

#import "Timer.h"

@implementation Timer

- (id) init {
    self = [super init];
    if (self != nil) {
        start = nil;
        end = nil;
    }
    return self;
}
- (void) startTimer {
    start = [NSDate date];
}
- (void) stopTimer {
    end = [NSDate date];
}
- (int) timeElapsedInSeconds {
    return [end timeIntervalSinceDate:start];
}
- (double) timeElapsedInMilliseconds {
    return [self timeElapsedInSeconds] * 1000.0f;
}
- (double) timeElapsedInMinutes {
    return [self timeElapsedInSeconds] / 60.0f;
}
@end
