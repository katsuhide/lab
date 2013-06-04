//
//  MyController.m
//  ViewTest
//
//  Created by AirMyac on 6/4/13.
//  Copyright (c) 2013 com.katzlifehack. All rights reserved.
//

#import "MyController.h"

@implementation MyController

-(id)init
{
    if (self = [super init]) {
        sort_accending = YES;
        images = [[NSMutableArray alloc] init];
        for (NSString* path in [[NSBundle mainBundle] pathsForResourcesOfType:@"tiff" inDirectory:nil]) {
            NSImage *image = [[NSImage alloc] initByReferencingFile:path];
            [images addObject:
             [NSMutableDictionary dictionaryWithObjectsAndKeys:image, @"image", [path lastPathComponent], @"name", nil]];
        }
    }
    return self;
}

- (IBAction)sort:(id)sender
{
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                               initWithKey:@"name"
                               ascending:(sort_accending = !sort_accending)];
    [array_controller setSortDescriptors:[NSArray arrayWithObject:sort]];
}

@end
