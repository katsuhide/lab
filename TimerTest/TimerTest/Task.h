//
//  Task.h
//  TimerTest
//
//  Created by AirMyac on 5/31/13.
//  Copyright (c) 2013 com.katzlifehack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

@property (assign) NSMutableString *lastExecuteTime;


- (id) initWith:(NSString *)str;

- (void) execute;

@end
