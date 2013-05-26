//
//  IEAppDelegate.h
//  CocoaTest
//
//  Created by AirMyac on 5/26/13.
//  Copyright (c) 2013 com.katzlifehack. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <EvernoteSDK-Mac/EvernoteSDK.h>

@interface IEAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTextField *notetitleField;
@property (assign) IBOutlet NSTokenField *tagField;
@property (assign) IBOutlet NSComboBox *notebookField;
@property (assign) EvernoteNoteStore *evernoteNoteStore;

@end
