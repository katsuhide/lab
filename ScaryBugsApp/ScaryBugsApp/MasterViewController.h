//
//  MasterViewController.h
//  ScaryBugsApp
//
//  Created by Ray Wenderlich on 8/11/12.
//  Copyright (c) 2012 Ray Wenderlich. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MasterViewController : NSViewController

@property (strong) NSMutableArray *bugs;

@property (strong) NSMutableArray *hoges;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
