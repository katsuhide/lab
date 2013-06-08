//
//  AppController.m
//  ViewTest
//
//  Created by AirMyac on 6/9/13.
//  Copyright (c) 2013 com.katzlifehack. All rights reserved.
//

#import "AppController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@implementation AppController

//@synthesize ourView = _ourView;
//@synthesize ourViewController = _ourViewController;

enum {
    kFirstViewTag = 0,
    kSecondViewTag
};

NSString *const kFirstView = @"FirstViewController";
NSString *const kSecondView = @"SecondViewController";

-(void)awakeFromNib{
    [self changeViewController:kFirstViewTag];
}

-(IBAction)changeView:(id)sender{
    NSInteger tag = [[sender selectedCell] tag];
    [self changeViewController:tag];
}

-(IBAction)openView:(id)sender{
    NSLog(@"open View");
    self.ourViewController = [[FirstViewController alloc]initWithNibName:kFirstView bundle:nil];
    
}

-(void)changeViewController:(NSInteger)tag{
    [[_ourViewController view] removeFromSuperview];
    switch (tag) {
        case kFirstViewTag:
            self.ourViewController = [[FirstViewController alloc]initWithNibName:kFirstView bundle:nil];
            break;
        case kSecondViewTag:
            self.ourViewController = [[SecondViewController alloc]initWithNibName:kSecondView bundle:nil];
            break;
    }
    [_ourView addSubview:[_ourViewController view]];
    [[_ourViewController view] setFrame:[_ourView bounds]];
}

@end
