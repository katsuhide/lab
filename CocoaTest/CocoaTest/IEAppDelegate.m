//
//  IEAppDelegate.m
//  CocoaTest
//
//  Created by AirMyac on 5/26/13.
//  Copyright (c) 2013 com.katzlifehack. All rights reserved.
//

#import "IEAppDelegate.h"
#import <CommonCrypto/CommonCrypto.h>
#import "NSData+EvernoteSDK.h"

@implementation IEAppDelegate

NSMutableArray *list;

- (void)dealloc
{
    [super dealloc];
}

/*
 * アプリ起動時
 */
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

    // 対象ファイルのインスタンスを生成(autorelease off)
    _attachFiles = [[NSMutableArray alloc] init];

}

/*
 * 画面オブジェクトを初期化
 */
- (void)clearItems{
    [_notetitleField setObjectValue:nil];
    [_tagField setObjectValue:nil];
    [_attachFiles removeAllObjects];
    [_notebookField selectItemAtIndex:0];
}


/*
 * hoge method
 */
- (IBAction)hoge:(id)sender{

    NSLog(@"aaaaaa");
    for(NSString *file in _attachFiles){
        NSLog(@"file:%@", file);
    }
    [self clearItems];
    NSLog(@"%@", [_notebookField stringValue]);
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
            [self addNote:noteStore];
            
            
        }
    }];
    
}

/*
 * NOTEBOOKの一覧を取得してcomboboxを初期化する
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
 * NOTEを追加登録する
 */
- (void)addNote:(EvernoteNoteStore*)noteStore {
    // Note Titleの指定
    NSString *noteTitle = [_notetitleField stringValue];
    // tagの指定
    NSMutableArray *tagNames = [_tagField objectValue];
    
    // Notebookの指定
    NSString *notebook = [_notebookField stringValue];
    
    // EDAMResourceをリストに格納
    NSMutableArray *resources = [[NSMutableArray alloc] init];
    [self createResources:_attachFiles andResouces:resources];
    
    
    // ENMLの作成
    NSMutableString* body = [NSMutableString string];
    // <en-note>
    [body appendFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?><!DOCTYPE en-note SYSTEM \"http://xml.evernote.com/pub/enml2.dtd\"><en-note>This is Mac SDK Test!!!!!!<br/>"];
    // <en-media>
    for(EDAMResource *resouce in resources){
        [body appendFormat:@"<en-media type=\""];
        [body appendFormat:resouce.mime];
        [body appendFormat:@"\" hash=\""];
        [body appendFormat: [resouce.data.bodyHash enlowercaseHexDigits]];
        [body appendFormat:@"\"/>"];
    }
    // </en-note>
    [body appendFormat:@"</en-note>"];
    NSLog(@"%@", body);
    
    // NOTEを登録
    EDAMNote* note = [[EDAMNote alloc] initWithGuid:nil title:noteTitle content:body contentHash:nil contentLength:0 created:0 updated:0 deleted:0 active:YES updateSequenceNum:0 notebookGuid:nil tagGuids:nil resources:resources attributes:nil tagNames:tagNames];
    [noteStore createNote:note success:^(EDAMNote *note) {
        NSLog(@"add note succeded!!");
        
    } failure:^(NSError *error) {
        NSLog(@"add note filed: %@", error);
    }];
    
    // 画面を初期化
    [self clearItems];

}

/*
 * ファイルパスからResourcesを作成
 */
- (void) createResources:(NSArray*) files andResouces:(NSMutableArray*) resouces{

    for(NSString *filePath in files){
        // 指定されたファイルパスからEDAMResourceを作成
        NSString *fileName = [filePath lastPathComponent];
        NSString *mime = [self mimeTypeForFileAtPath:filePath];
        NSData *myFileData = [NSData dataWithContentsOfFile:filePath];
        NSData *bodyHash = [myFileData enmd5];
        EDAMData *edamData = [[EDAMData alloc] initWithBodyHash:bodyHash size:myFileData.length body:myFileData];
        EDAMResourceAttributes *attribute = [[EDAMResourceAttributes alloc] init];
        attribute.fileName = fileName;
        EDAMResource* resource = [[EDAMResource alloc] initWithGuid:nil noteGuid:nil data:edamData mime:mime width:0 height:0 duration:0 active:0 recognition:0 attributes:attribute updateSequenceNum:0 alternateData:nil];
        [resouces addObject:resource];
    }
}



/*
 * ファイルパスからMIMEを取得する
 */
- (NSString*) mimeTypeForFileAtPath: (NSString *) path {
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return nil;
    }
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (CFStringRef)[path pathExtension], NULL);
    CFStringRef mimeType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
    CFRelease(UTI);
    if (!mimeType) {
        return @"application/octet-stream";
    }
    return [NSMakeCollectable((NSString *)mimeType) autorelease];
}



@end
