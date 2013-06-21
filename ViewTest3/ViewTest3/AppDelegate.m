//
//  AppDelegate.m
//  ViewTest3
//
//  Created by AirMyac on 6/19/13.
//  Copyright (c) 2013 com.katzlifehack. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    _imageFlag = true;
    NSImage *image = [self createImage];
    [_button setImage:image];
    [_button setBordered:NO];
    
    [self initializedTableView];
}

-(IBAction)changeBtnImage:(id)sender{
    NSImage *image = [self createImage];
    [_button setImage:image];

}


-(NSImage*)createImage{
    NSString *file;
    if(_imageFlag){
        file = @"/Users/AirMyac/github/lab/ViewTest3/ViewTest3/clear.png";
        _imageFlag = false;
    }else{
        file = @"/Users/AirMyac/github/lab/ViewTest3/ViewTest3/ng.png";
        _imageFlag = true;
    }
    NSImage *image = [[NSImage alloc]initByReferencingFile:file];
    return image;
}

-(void)initializedTableView{
    
    NSMutableArray *objects = [NSMutableArray array];
    for (int i = 0; i < 7; i++) {
        ViewDataModel *model = [[ViewDataModel alloc]init];
        model.status = i;
        model.type = @"skype";
        model.name = @"hoge";
        [objects addObject:model];
    }
    [_arrayController setContent:objects];
    
}


@end
