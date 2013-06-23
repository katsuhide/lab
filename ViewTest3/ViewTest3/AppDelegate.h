//
//  AppDelegate.h
//  ViewTest3
//
//  Created by AirMyac on 6/19/13.
//  Copyright (c) 2013 com.katzlifehack. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ViewDataModel.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSButton *button;
@property (assign) IBOutlet NSButton *registerBtn;
@property (assign) IBOutlet NSButton *infoBtn;
@property (assign) IBOutlet NSButton *deleteBtn;
@property (assign) IBOutlet NSTableView *table;
@property (assign) BOOL imageFlag;
@property (assign) NSTextField *timeLabel;
@property (assign) IBOutlet NSArrayController *arrayController;

-(IBAction)changeBtnImage:(id)sender;

@end
