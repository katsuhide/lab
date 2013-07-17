//
//  AppDelegate.h
//  WebPDF
//
//  Created by AirMyac on 7/17/13.
//  Copyright (c) 2013 com.katzlifehack. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSTextField *urlField;

@property (assign) IBOutlet NSWindow *window;

@property (weak) IBOutlet WebView *webView;

- (IBAction)loadWebPage:(id)sender;

- (IBAction)savePDF:(id)sender;

@end
