//
//  AppDelegate.h
//  ViewTest2
//
//  Created by AirMyac on 6/13/13.
//  Copyright (c) 2013 com.katzlifehack. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (retain) IBOutlet NSTextField *str;

-(IBAction)hoge:(id)sender;

- (IBAction)saveAction:(id)sender;

@end
