//
//  IEAppDelegate.h
//  TimerTest
//
//  Created by AirMyac on 5/31/13.
//  Copyright (c) 2013 com.katzlifehack. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Task.h"
#import "TaskForSkype.h"
#import "TaskForFile.h"
#import "NSDate+Util.h"
#import "SQLiteManager.h"
#import "FMDatabase.h"

@interface IEAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@end
