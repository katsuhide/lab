//
//  AppDelegate.m
//  ViewTest
//
//  Created by AirMyac on 6/3/13.
//  Copyright (c) 2013 com.katzlifehack. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewDataModel.h"

@implementation AppDelegate

@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
    NSLog(@"hoge");
    
    NSMutableArray *objects = [NSMutableArray array];
    
    for (int i = 0; i < 7; i++) {
        ViewDataModel *model = [[ViewDataModel alloc] init];
        NSMutableArray *array = [[NSMutableArray alloc]init];
        [array addObject:@"aaaaaa"];
        [array addObject:@"hoge"];
        [array addObject:@"fuga"];
        model.name = array;
        model.hoge = [NSString stringWithFormat:@"hoge %@", @"hoge"];
        model.fuga = [NSString stringWithFormat:@"fuga %d", i];
        [objects addObject:model];
    }
    
    
    [_arrayController setContent:objects];
    
    // Insert code here to initialize your application
    // 初回起動用にDataStore用のDirectoryの有無を確認して無ければ作成する
    NSURL *applicationFilesDirectory = [self applicationFilesDirectory];
    NSError *error = nil;
    if(![[NSFileManager defaultManager] createDirectoryAtPath:[applicationFilesDirectory path] withIntermediateDirectories:YES attributes:nil error:&error]){
        NSLog(@"Couldn't create the data store directory.[%@, %@]", error, [error userInfo]);
        abort();
    }

}

-(IBAction)opneView:(id)sender{
    NSLog(@"open test");
    [_subWindow setWorksWhenModal:YES];
    [_subWindow setLevel:10];
    [_subWindow orderFront:sender];
    
}

-(IBAction)modal:(id)sender{
    NSLog(@"modal test");
    [_subWindow setWorksWhenModal:YES];
    [_subWindow setLevel:10];
}


-(IBAction)viewtest:(id)sender{
    NSLog(@"view test");
    [_subWindow close];
}

- (IBAction)hoge:(id)sender{

    // 選択された行番号を取得
    NSInteger *row = [_table selectedRow];
    NSLog(@"row:%d", row);
    // arrayControllerの選択を指定された番号にセット
    [_arrayController setSelectionIndex:row];
    // 選択されたデータを取得
    NSMutableArray *object = [[NSMutableArray alloc]init];
    object = [_arrayController selectedObjects];
    for(ViewDataModel *model in object){
        NSLog(@"%@", model.fuga);
    }

    // 選択された行を削除
    [_arrayController removeObjectAtArrangedObjectIndex:row];
    
    // 追加用のデータモデルを定義
    ViewDataModel *model = [[ViewDataModel alloc]init];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    [array addObject:@"aaaaaa"];
    [array addObject:@"hoge"];
    [array addObject:@"fuga"];
    model.name = array;
    model.hoge = [NSString stringWithFormat:@"hoge %@", @"dagagadag"];
    model.fuga = [NSString stringWithFormat:@"fuga %d", 1234];
    // データを追加
//    [_arrayController addObject:model];

}

// Returns the directory the application uses to store the Core Data store file. This code uses a directory named "katz.ViewTest" in the user's Application Support directory.
- (NSURL *)applicationFilesDirectory
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *appSupportURL = [[fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
    return [appSupportURL URLByAppendingPathComponent:@"katz.ViewTest"];
}

// Creates if necessary and returns the managed object model for the application.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
	
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ViewTest" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. (The directory for the store is created, if necessary.)
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
    
    NSManagedObjectModel *mom = [self managedObjectModel];
    if (!mom) {
        NSLog(@"%@:%@ No model to generate a store from", [self class], NSStringFromSelector(_cmd));
        return nil;
    }
    
    NSURL *applicationFilesDirectory = [self applicationFilesDirectory];
    NSError *error = nil;
    
    NSURL *url = [applicationFilesDirectory URLByAppendingPathComponent:@"main.sqlite"];
    
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    if (![coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    _persistentStoreCoordinator = coordinator;
    
    return _persistentStoreCoordinator;
}

// Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) 
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:@"Failed to initialize the store" forKey:NSLocalizedDescriptionKey];
        [dict setValue:@"There was an error building up the data file." forKey:NSLocalizedFailureReasonErrorKey];
        NSError *error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        [[NSApplication sharedApplication] presentError:error];
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];

    return _managedObjectContext;
}

// Returns the NSUndoManager for the application. In this case, the manager returned is that of the managed object context for the application.
- (NSUndoManager *)windowWillReturnUndoManager:(NSWindow *)window
{
    return [[self managedObjectContext] undoManager];
}

// Performs the save action for the application, which is to send the save: message to the application's managed object context. Any encountered errors are presented to the user.
- (IBAction)saveAction:(id)sender
{
    NSError *error = nil;
    
    if (![[self managedObjectContext] commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing before saving", [self class], NSStringFromSelector(_cmd));
    }
    
    if (![[self managedObjectContext] save:&error]) {
        [[NSApplication sharedApplication] presentError:error];
    }
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender
{
    // Save changes in the application's managed object context before the application terminates.
    
    if (!_managedObjectContext) {
        return NSTerminateNow;
    }
    
    if (![[self managedObjectContext] commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing to terminate", [self class], NSStringFromSelector(_cmd));
        return NSTerminateCancel;
    }
    
    if (![[self managedObjectContext] hasChanges]) {
        return NSTerminateNow;
    }
    
    NSError *error = nil;
    if (![[self managedObjectContext] save:&error]) {

        // Customize this code block to include application-specific recovery steps.              
        BOOL result = [sender presentError:error];
        if (result) {
            return NSTerminateCancel;
        }

        NSString *question = NSLocalizedString(@"Could not save changes while quitting. Quit anyway?", @"Quit without saves error question message");
        NSString *info = NSLocalizedString(@"Quitting now will lose any changes you have made since the last successful save", @"Quit without saves error question info");
        NSString *quitButton = NSLocalizedString(@"Quit anyway", @"Quit anyway button title");
        NSString *cancelButton = NSLocalizedString(@"Cancel", @"Cancel button title");
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:question];
        [alert setInformativeText:info];
        [alert addButtonWithTitle:quitButton];
        [alert addButtonWithTitle:cancelButton];

        NSInteger answer = [alert runModal];
        
        if (answer == NSAlertAlternateReturn) {
            return NSTerminateCancel;
        }
    }

    return NSTerminateNow;
}

// NSManagedObjectの生成
-(NSManagedObject*)createObject:(NSString*)entity_name{
    return [NSEntityDescription insertNewObjectForEntityForName:entity_name inManagedObjectContext:self.managedObjectContext];
}

// NSFetchRequestの生成
-(NSFetchRequest*)createRequest:(NSString*)entity_name{
    return [[NSFetchRequest alloc] initWithEntityName:entity_name];
}

// Save
-(void)save{
    NSError *error = nil;
    if (![[self managedObjectContext] commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing before saving", [self class], NSStringFromSelector(_cmd));
    }
    if (![[self managedObjectContext] save:&error]) {
        [[NSApplication sharedApplication] presentError:error];
    }
}


// register method
- (IBAction)registerAction:(id)sender{
    // NSManagedObjectの生成
    TaskSource *source = (TaskSource*)[self createObject:@"TaskSource"];
    source.task_name = @"Other Task1";
    source.task_type = @"other";
    source.interval = @"10";
    source.tags = @"tag1,tag2";
    source.note_title = @"Other Task Note Title1";
    source.update_time = [NSDate date];
    [self save];
}

// get method
- (IBAction)getAction:(id)sender{
    NSFetchRequest *fetchRequest = [self createRequest:@"TaskSource"];
    NSError *error = nil;
    NSArray *result = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if(!result){
        NSLog(@"%@:%@", error, [error userInfo]);
    }else{
        for(TaskSource *taskSource in result) {
            [taskSource print];
        }
    }
}



@end
