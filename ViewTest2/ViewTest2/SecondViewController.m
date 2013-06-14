//
//  SecondViewController.m
//  ViewTest2
//
//  Created by AirMyac on 6/15/13.
//  Copyright (c) 2013 com.katzlifehack. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(NSString*)first{
    return [_secondTask stringValue];
}

@end
