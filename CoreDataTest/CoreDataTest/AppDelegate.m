//
//  AppDelegate.m
//  CoreDataTest
//
//  Created by AirMyac on 6/3/13.
//  Copyright (c) 2013 com.katzlifehack. All rights reserved.
//

#import "AppDelegate.h"
#import "Hoge.h"
#import "Fuga.h"
#import "TaskSource.h"
#import "Notebook.h"

@implementation AppDelegate

@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

// Returns the directory the application uses to store the Core Data store file. This code uses a directory named "katz.CoreDataTest" in the user's Application Support directory.
- (NSURL *)applicationFilesDirectory
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *appSupportURL = [[fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
    return [appSupportURL URLByAppendingPathComponent:@"katz.CoreDataTest"];
}

// Creates if necessary and returns the managed object model for the application.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
	
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreDataTest" withExtension:@"momd"];
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

-(NSManagedObject*)insert:(NSString*)entity_name{
    
    return [NSEntityDescription insertNewObjectForEntityForName:entity_name inManagedObjectContext:self.managedObjectContext];

}



-(NSFetchRequest*)createRequest:(NSString*)entity_name{
    return [[NSFetchRequest alloc] initWithEntityName:entity_name];
}

- (IBAction)select:(id)sender{
    // TaskSource
    NSFetchRequest *request = [self createRequest:@"TaskSource"];
    NSError *error = nil;
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    for(TaskSource *taskSource in result) {
        [taskSource print];
    }

    // Notebook
    request = [self createRequest:@"Notebook"];
    result = [self.managedObjectContext executeFetchRequest:request error:&error];
    for(Notebook *notebook in result) {
        [notebook print];
    }
    
    NSFetchRequest *fetchRequest = [self createRequest:@"TaskSource"];
    
    // ソート条件配列を作成
    NSSortDescriptor *desc;
    desc = [[NSSortDescriptor alloc] initWithKey:@"interval" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:desc, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // 取得条件の設定
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"task_name = %@", @"task1"];
//    [fetchRequest setPredicate:pred];
    
    // 取得最大数の設定
//    [fetchRequest setFetchBatchSize:10];
    [fetchRequest setFetchLimit:1];
    
    // データ取得用コントローラを作成
    NSArray *result3 = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    NSLog(@"fetch");
    for(TaskSource *taskSource in result3) {
        [taskSource print];
    }

    
    NSLog(@"sum");
    request = [self createRequest:@"TaskSource"];

    //集計の対象を設定します。
    NSExpression *keyPathExpression = [NSExpression expressionForKeyPath:@"interval"];
    
    //集計関数(sum)の指定
    NSExpression *expression = [NSExpression expressionForFunction:@"sum:" arguments:[NSArray arrayWithObject:keyPathExpression]];
    
    //集計式の対象（NSExpressionDescription ）
    NSExpressionDescription *expressionDescription = [[NSExpressionDescription alloc] init];
    [expressionDescription setName:@"sumInterval"]; //集計式の名
    [expressionDescription setExpression:expression]; //集計関数
    [expressionDescription setExpressionResultType:NSInteger32AttributeType]; //結果の種類
    
    //集計式の対象をリクエストに設置します。集計グールプを「month」に設定します。
    [request setPropertiesToGroupBy:[NSArray arrayWithObject:@"task_name"]];
    [request setPropertiesToFetch:[NSArray arrayWithObjects: expressionDescription, @"task_name", Nil]];
    [request setResultType:NSDictionaryResultType];
    
    
    //結果を取得します。
    NSArray *objs= [self.managedObjectContext executeFetchRequest:request error:nil];
    for(int i=0; i < objs.count; i++){
        NSArray *array = [objs objectAtIndex:i];
        NSLog(@"%@:%@", [array valueForKey:@"task_name"], [array valueForKey:@"sumInterval"]);
    }
    
}



- (IBAction)setup:(id)sender{
    // Taskのレコードを登録
    TaskSource *taskSource = (TaskSource*)[self insert:@"TaskSource"];
    taskSource.task_name = @"task1";
    taskSource.interval = [[NSNumber alloc]initWithInt:10];
    taskSource.tag = @"tag1,tag2,tag3";
    taskSource.params = @"key1:value1,key2:value2";

    NSFetchRequest *request = [self createRequest:@"Notebook"];
    NSError *error = nil;
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    Notebook *notebook = [result objectAtIndex:0];
//    Notebook *notebook = (Notebook*)[self insert:@"Notebook"];
//    notebook.guid = @"0001";
//    notebook.name = @"notebook1";
    taskSource.notebook = notebook;
    [self save];
    NSLog(@"setup end.");
    
}

-(void)save{
    NSError *error = nil;
    if (![[self managedObjectContext] commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing before saving", [self class], NSStringFromSelector(_cmd));
    }
    if (![[self managedObjectContext] save:&error]) {
        [[NSApplication sharedApplication] presentError:error];
    }
}

- (IBAction)hog2:(id)sender{
    NSLog(@"insert");
    Hoge *hoge = [NSEntityDescription insertNewObjectForEntityForName:@"Hoge" inManagedObjectContext:self.managedObjectContext];
    hoge.name = @"test";
    
    NSError *error = nil;
    
    if (![[self managedObjectContext] commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing before saving", [self class], NSStringFromSelector(_cmd));
    }
    
    if (![[self managedObjectContext] save:&error]) {
        [[NSApplication sharedApplication] presentError:error];
    }

    
    NSLog(@"get");
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Hoge"];
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];

    for(Hoge *hoge in result) {
        NSLog(@"%@", hoge.name);
    }
    
    NSLog(@"insert2");
    Fuga *fuga = [NSEntityDescription insertNewObjectForEntityForName:@"Fuga" inManagedObjectContext:self.managedObjectContext];
    fuga.task_id = [[NSNumber alloc]initWithDouble:1.0];
    fuga.date = [NSDate date];
    fuga.name = @"fuga";
    
    if (![[self managedObjectContext] commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing before saving", [self class], NSStringFromSelector(_cmd));
    }
    
    if (![[self managedObjectContext] save:&error]) {
        [[NSApplication sharedApplication] presentError:error];
    }
    
    
    NSLog(@"get2");
    NSFetchRequest *request2 = [[NSFetchRequest alloc] initWithEntityName:@"Fuga"];
    NSArray *result2 = [self.managedObjectContext executeFetchRequest:request2 error:&error];
    
    for(Fuga *fuga in result2) {
        NSLog(@"%@:%@:%@", fuga.task_id, fuga.name, [fuga.date description]);
    }

    
}


@end
