//
//  MyController.h
//  ViewTest
//
//  Created by AirMyac on 6/4/13.
//  Copyright (c) 2013 com.katzlifehack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyController : NSObject{
    NSMutableArray *images;
    BOOL sort_accending;
    IBOutlet NSArrayController *array_controller;
}

- (IBAction)sort:(id)sender;

@end
