//
//  IEAppDelegate.m
//  InputEver
//
//  Created by AirMyac on 5/13/13.
//  Copyright (c) 2013 com.katzlifehack. All rights reserved.
//

#import "IEAppDelegate.h"

@implementation IEAppDelegate
@synthesize window = _window;

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag {
    // windowを前面に
    [self.window makeKeyAndOrderFront:nil];
    return NO;
}

@end
