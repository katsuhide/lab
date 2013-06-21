//
//  TestButton.m
//  ViewTest3
//
//  Created by AirMyac on 6/19/13.
//  Copyright (c) 2013 com.katzlifehack. All rights reserved.
//

#import "TestButton.h"

@implementation TestButton

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
    NSString *file = @"/Users/AirMyac/Downloads/1371632212_4.png";
    NSImage *image = [[NSImage alloc]initByReferencingFile:file];
    [self setImage:image];

}

@end
