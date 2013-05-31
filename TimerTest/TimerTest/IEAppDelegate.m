//
//  IEAppDelegate.m
//  TimerTest
//
//  Created by AirMyac on 5/31/13.
//  Copyright (c) 2013 com.katzlifehack. All rights reserved.
//

#import "IEAppDelegate.h"

@implementation IEAppDelegate

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    // Create the Timer
    NSNumber *number = [[NSNumber alloc] initWithInt:1];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:number forKey:@"count"];
    NSTimer *timer = [NSTimer
                      scheduledTimerWithTimeInterval:3.f
                      target:self
                      selector:@selector(polling:)
                      userInfo:dic
                      repeats:YES];
    
}


// Polling処理
- (void)polling: (NSTimer*)timer{
    
    NSNumber *number = [[timer userInfo] objectForKey:@"count"];
    NSLog(@"count up:%@", number);
    int sum = [number intValue];
    sum = sum + 1;
    [[timer userInfo] setObject:[[NSNumber alloc]initWithInt:sum] forKey:@"count"];
    
}



@end
