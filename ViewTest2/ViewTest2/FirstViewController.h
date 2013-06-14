//
//  FirstViewController.h
//  ViewTest2
//
//  Created by AirMyac on 6/15/13.
//  Copyright (c) 2013 com.katzlifehack. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface FirstViewController : NSViewController

@property (assign) IBOutlet NSTextField *firstText;

-(NSString*)first;

-(IBAction)firstBtn:(id)sender;

@end
