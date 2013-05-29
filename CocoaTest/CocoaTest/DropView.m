//
//  DropView.m
//  CocoaTest
//
//  Created by AirMyac on 5/26/13.
//  Copyright (c) 2013 com.katzlifehack. All rights reserved.
//

#import "DropView.h"
#import "IEAppDelegate.h"

@implementation DropView

extern NSMutableArray *list;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self registerForDraggedTypes:[NSArray arrayWithObjects:
                                       NSColorPboardType, NSFilenamesPboardType, nil]];
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
}

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender {
    NSPasteboard *pboard;
    NSDragOperation sourceDragMask;
    
    sourceDragMask = [sender draggingSourceOperationMask];
    pboard = [sender draggingPasteboard];
    
    if ( [[pboard types] containsObject:NSColorPboardType] ) {
        if (sourceDragMask & NSDragOperationGeneric) {
            return NSDragOperationGeneric;
        }
    }
    if ( [[pboard types] containsObject:NSFilenamesPboardType] ) {
        if (sourceDragMask & NSDragOperationLink) {
            return NSDragOperationLink;
        } else if (sourceDragMask & NSDragOperationCopy) {
            return NSDragOperationCopy;
        }
    }
    return NSDragOperationNone;
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender {
    NSPasteboard *pboard;
    NSDragOperation sourceDragMask;
    
    sourceDragMask = [sender draggingSourceOperationMask];
    pboard = [sender draggingPasteboard];
    
    if ( [[pboard types] containsObject:NSFilenamesPboardType] ) {
        NSArray *files = [pboard propertyListForType:NSFilenamesPboardType];
        IEAppDelegate *appDelegate = (IEAppDelegate*)[[NSApplication sharedApplication] delegate];
        NSLog(@"%@", files);
        // 初期化(TODO:ここで初期化しない方がいい？
//        [appDelegate.attachFiles removeAllObjects];
        // ドラッグされたファイルを対象ファイルにセット
        [appDelegate.attachFiles addObjectsFromArray:files];

    }
    return YES;
}

@end
