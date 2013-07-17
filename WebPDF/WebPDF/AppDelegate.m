//
//  AppDelegate.m
//  WebPDF
//
//  Created by AirMyac on 7/17/13.
//  Copyright (c) 2013 com.katzlifehack. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
}

// Webページを開く
- (IBAction)loadWebPage:(id)sender
{
    NSLog(@"load web page");
    
    NSString *urlAddress = [_urlField stringValue];
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [[_webView mainFrame] loadRequest:requestObj];
    
}


- (IBAction)savePDF:(id)sender
{
    [self savePDFbyNormal];
    [self savePDFbyPrinter];
//    [self saveImage];
    NSLog(@"save");
    
}

// WebViewをpdfとして保存
-(void)savePDFbyNormal{
    [_webView setMediaStyle:@"screen"];
    NSView* view = [[[_webView mainFrame] frameView] documentView];
    NSRect rect = [view bounds];
    NSData* outdata = [view dataWithPDFInsideRect:rect];
    NSString* path = @"/Users/AirMyac/Desktop/normal.pdf";
    [outdata writeToFile:path atomically:YES];
    
}

// WebViewを印刷ダイアログを使ってpdfとして保存
-(void)savePDFbyPrinter{
    
    // (1) setup filename
    NSString* path = @"/Users/AirMyac/Desktop/printer.pdf";
    
    // (2) setup WebView
//    [_webView setMediaStyle:@"screen"];
    [_webView setMediaStyle:@"screen"];
    NSView* view = [[[_webView mainFrame] frameView] documentView];
    
    // (3) setup NSDictionary for NSPrintInfo
    NSMutableDictionary* p_dict = [NSMutableDictionary
                                   dictionaryWithDictionary:[[NSPrintInfo sharedPrintInfo] dictionary]];
    [p_dict setObject:NSPrintSaveJob forKey:NSPrintJobDisposition];
    [p_dict setObject:path forKey:NSPrintSavePath];
    
    // (4) setup NSPrintInfo
    NSPrintInfo* p_info = [[NSPrintInfo alloc] initWithDictionary:p_dict];
    [p_info setHorizontalPagination:NSAutoPagination];
    [p_info setVerticalPagination:NSAutoPagination];
    [p_info setVerticallyCentered:NO];
    
    // (5) setup NSPrintOperation
    NSPrintOperation* p_ope = [NSPrintOperation printOperationWithView:view printInfo:p_info];
    [p_ope setShowPanels:NO];
    
    // (6) print it
    [p_ope runOperation];
    
}

-(void)saveImage{
    
    {
        NSBitmapImageRep* bitmap =
        [_webView bitmapImageRepForCachingDisplayInRect:[_webView bounds]];
        [_webView cacheDisplayInRect:[_webView bounds]
                     toBitmapImageRep:bitmap];
        
        NSData* outdata = [bitmap representationUsingType:NSPNGFileType
                                               properties:[NSDictionary dictionary]];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                             NSDesktopDirectory, NSUserDomainMask, YES);
        NSString* path = @"/Users/AirMyac/Desktop/image.png";
        
        [outdata writeToFile:path atomically:YES];
    }
    
}


@end
