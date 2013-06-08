//
//  AppController.h
//  ViewTest
//
//  Created by AirMyac on 6/9/13.
//  Copyright (c) 2013 com.katzlifehack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppController : NSObject

@property (weak) IBOutlet NSView *ourView;
@property (strong) NSViewController *ourViewController;

- (IBAction)changeView:(id)sender;
- (void)changeViewController:(NSInteger)tag;

@end
