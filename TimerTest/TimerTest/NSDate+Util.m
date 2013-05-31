//
//  NSDate+Util.m
//  TimerTest
//
//  Created by AirMyac on 6/1/13.
//  Copyright (c) 2013 com.katzlifehack. All rights reserved.
//

#import "NSDate+Util.h"

@implementation NSDate (Util)

- (NSDate*)toLocalTime{
    
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    NSInteger seconds = [tz secondsFromGMTForDate: self];
    return [NSDate dateWithTimeInterval: seconds sinceDate: self];

}

@end
