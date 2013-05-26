//
//  IEAppDelegate.m
//  CocoaTest
//
//  Created by AirMyac on 5/26/13.
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
    NSString *EVERNOTE_HOST = BootstrapServerBaseURLStringSandbox;
    NSString *CONSUMER_KEY = @"katzlifehack";
    NSString *CONSUMER_SECRET = @"9490d8896d0bb1a3";
    
    // set up Evernote session singleton
    [EvernoteSession setSharedSessionHost:EVERNOTE_HOST
                              consumerKey:CONSUMER_KEY
                           consumerSecret:CONSUMER_SECRET];

    
}

- (IBAction)hoge:(id)sender{
    NSLog(@"aaaaaa");
    [_notetitleField setStringValue:@"fugafuga"];
    NSString *str = _notetitleField.stringValue;
    NSLog(@"str:%@",str);
    
}


/*
 * Evernote OAuth認証
 */
- (IBAction)doAuthenticate:(id)sender {
    
    EvernoteSession *session = [EvernoteSession sharedSession];
    
    [session authenticateWithWindow:self.window completionHandler:^(NSError *error) {
        if (error || !session.isAuthenticated) {
            NSRunCriticalAlertPanel(@"Error", @"Could not authenticate", @"OK", nil, nil);
        }
        else {
            NSLog(@"authenticationToken:%@", session.authenticationToken);
            
            EvernoteNoteStore *noteStore = [EvernoteNoteStore noteStore];
            _evernoteNoteStore = noteStore;
            
            [self clearNotebookField:noteStore];
            
            
        }
    }];
    
    
}

/*
 * Evernote Note登録
 */
- (IBAction)doAddNote:(id)sender {
    NSLog(@"doAddNote");
    [self addNote:_evernoteNoteStore];
    
}

/*
 * notebookの一覧を取得してcomboboxを初期化する
 */

- (void)clearNotebookField:(EvernoteNoteStore*)noteStore {
    
    [noteStore listNotebooksWithSuccess:^(NSArray *notebooks) {
        
        for(EDAMNotebook *notebook in notebooks){
            [_notebookField addItemWithObjectValue:notebook.name];
        }
        
    } failure:^(NSError *error2) {
        NSLog(@"error %@", error2);
    }];
    
}

/*
 * noteをポストする
 */
- (void)addNote:(EvernoteNoteStore*)noteStore {
    NSLog(@"addNote");
    EDAMNote *note = nil;
    [noteStore createNote:note success:^(EDAMNote *note) {
        NSLog(@"hoge");
        
    } failure:^(NSError *error) {
        NSLog(@"add note:%@", error);
    }];

    
}

@end
