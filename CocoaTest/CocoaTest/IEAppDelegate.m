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

    NSString *body = @"<?xml version=\"1.0\" encoding=\"UTF-8\"?><!DOCTYPE en-note SYSTEM \"http://xml.evernote.com/pub/enml2.dtd\"><en-note>This is Mac SDK Test!!<br/>";
    NSLog(@"body:%@", body);

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

    EvernoteSession *session = [EvernoteSession sharedSession];
    
    [session authenticateWithWindow:self.window completionHandler:^(NSError *error) {
        if (error || !session.isAuthenticated) {
            NSRunCriticalAlertPanel(@"Error", @"Could not authenticate", @"OK", nil, nil);
        }
        else {
            NSLog(@"authenticationToken:%@", session.authenticationToken);
            
            EvernoteNoteStore *noteStore = [EvernoteNoteStore noteStore];
            _evernoteNoteStore = noteStore;
            
            [self addNote:_evernoteNoteStore];
            
        }
    }];
    
    
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
    
    NSMutableArray *tagNames = [NSMutableArray arrayWithObjects:@"evernote",@"sdk", nil];
//    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"evernote_logo_4c-sm" ofType:@"png"];
//    NSData *myFileData = [NSData dataWithContentsOfFile:filePath];
//    NSData *dataHash = [myFileData enmd5];
//    EDAMData *edamData = [[EDAMData alloc] initWithBodyHash:dataHash size:myFileData.length body:myFileData];
//    EDAMResource* resource = [[EDAMResource alloc] initWithGuid:nil noteGuid:nil data:edamData mime:@"image/png" width:0 height:0 duration:0 active:0 recognition:0 attributes:nil updateSequenceNum:0 alternateData:nil];
//    NSMutableArray *resources = [NSMutableArray arrayWithObjects:resource,resource, nil];
//    EDAMNote* notebook = [[EDAMNote alloc] initWithGuid:nil title:@"Test Note - Evernote SDK" content:@"<strong>Here is my new HTML note</strong>" contentHash:nil contentLength:0 created:0 updated:0 deleted:0 active:YES updateSequenceNum:0 notebookGuid:nil tagGuids:nil resources:resources attributes:nil tagNames:tagNames];
    
    NSLog(@"2");

    NSString *body = @"<?xml version=\"1.0\" encoding=\"UTF-8\"?><!DOCTYPE en-note SYSTEM \"http://xml.evernote.com/pub/enml2.dtd\"><en-note>This is Mac SDK Test!!<br/></en-note>";
    NSLog(@"body:%@", body);
    
    EDAMNote* notebook = [[EDAMNote alloc] initWithGuid:nil title:@"Test Note - Evernote SDK" content:body contentHash:nil contentLength:0 created:0 updated:0 deleted:0 active:YES updateSequenceNum:0 notebookGuid:nil tagGuids:nil resources:nil attributes:nil tagNames:tagNames];

//    [[EvernoteSession sharedSession] setDelegate:self];
//    [noteStore saveNewNoteToEvernoteApp:note withType:@"text/html"];

    NSLog(@"1");
    
    [noteStore createNote:notebook success:^(EDAMNote *note) {
        NSLog(@"hoge");
        
    } failure:^(NSError *error) {
        NSLog(@"add note:%@", error);
    }];

    NSLog(@"3");

}

@end
