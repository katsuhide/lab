//
//  SecondViewController.h
//  ViewTest2
//
//  Created by AirMyac on 6/15/13.
//  Copyright (c) 2013 com.katzlifehack. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SecondViewController : NSViewController

@property (retain) IBOutlet NSTextField *secondTask;
@property (retain) IBOutlet NSTextField *secondParams;

-(NSString*)first;

@end
