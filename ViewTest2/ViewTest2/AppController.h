//
//  AppController.h
//  ViewTest2
//
//  Created by AirMyac on 6/13/13.
//  Copyright (c) 2013 com.katzlifehack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface AppController : NSObject

@property (weak) IBOutlet NSView *mainView;
@property (strong) NSViewController *mainViewController;
@property (retain) FirstViewController *firstCont;
@property (retain) SecondViewController *secondCont;

@property (assign) IBOutlet NSPopUpButton *btn;

-(NSString*)getField;

-(IBAction)fuga:(id)sender;

- (IBAction)changeView:(id)sender;

-(IBAction)getPrint:(id)sender;

- (void)changeViewController:(NSInteger)tag;

-(IBAction)printAll:(id)sender;

@end
