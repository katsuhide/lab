//
//  FirstViewController.m
//  ViewTest2
//
//  Created by AirMyac on 6/15/13.
//  Copyright (c) 2013 com.katzlifehack. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(IBAction)firstBtn:(id)sender{
    NSLog(@"firstBtn:%@", [self first]);
    
}

-(NSString*)first{
    NSString *str = [_firstText stringValue];
    NSLog(@"first:%@", str);
    return str;
    
}

@end
