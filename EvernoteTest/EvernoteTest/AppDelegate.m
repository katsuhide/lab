//
//  AppDelegate.m
//  EvernoteTest
//
//  Created by AirMyac on 6/2/13.
//  Copyright (c) 2013 com.katzlifehack. All rights reserved.
//

#import "AppDelegate.h"
#import <CommonCrypto/CommonCrypto.h>
#import "NSData+EvernoteSDK.h"

@implementation AppDelegate

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
            [self clearNotebookField:noteStore];
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
            NSLog(@"%@", notebook.name);
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
    NSString *noteTitle = @"titletest";
    // tagの指定
    NSMutableArray *tagNames = [[NSMutableArray alloc]initWithObjects:@"tagtest", nil];
    
    // EDAMResourceをリストに格納
    NSString *path = @"/Users/AirMyac/Desktop/fuga.txt";
    NSMutableArray *files = [[NSMutableArray alloc] initWithObjects:path, nil];
    NSMutableArray *resources = [[NSMutableArray alloc] init];
    [self createResources:files andResouces:resources];
    
    
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
//    NSLog(@"%@", body);
    
    // NOTEを登録
    EDAMNote* hoge = [[EDAMNote alloc] initWithGuid:nil title:noteTitle content:body contentHash:nil contentLength:body.length created:0 updated:0 deleted:0 active:YES updateSequenceNum:0 notebookGuid:nil tagGuids:nil resources:resources attributes:nil tagNames:tagNames];
    NSLog(@"%@",hoge);
 
    NSString *noteContent = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
                             "<!DOCTYPE en-note SYSTEM \"http://xml.evernote.com/pub/enml2.dtd\">"
                             "<en-note>"
                             "%@"
                             "</en-note>",@"hoge is hoge"];
//    // Parent notebook is optional; if omitted, default notebook is used
//    NSString* parentNotebookGUID;
//    if(parentNotebook) {
//        parentNotebookGUID = parentNotebook.guid;
//    }
    
    NSLog(@"%@", noteContent);
    EDAMNote *ourNote = [[EDAMNote alloc] initWithGuid:nil title:@"noteTile" content:noteContent contentHash:nil contentLength:noteContent.length created:0 updated:0 deleted:0 active:YES updateSequenceNum:0 notebookGuid:nil tagGuids:nil resources:nil attributes:nil tagNames:nil];
    
    [[EvernoteNoteStore noteStore] createNote:ourNote success:^(EDAMNote *note) {
        // Log the created note object
        NSLog(@"Note created : %@",note);
    } failure:^(NSError *error) {
        // Something was wrong with the note data
        // See EDAMErrorCode enumeration for error code explanation
        // http://dev.evernote.com/documentation/reference/Errors.html#Enum_EDAMErrorCode
        NSLog(@"Error : %@",error);
    }];
    
    [noteStore createNote:hoge success:^(EDAMNote *note) {
        NSLog(@"add note succeded!!");
        
    } failure:^(NSError *error) {
        NSLog(@"add note filed: %@", error);
    }];
    
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
