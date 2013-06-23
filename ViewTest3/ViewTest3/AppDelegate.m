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
    [self initialized];
    [self initializedTableView];
}

-(void)initialized{
    // statusBtn
    _imageFlag = true;
    NSImage *image = [self createImage];
    [_button setImage:image];
    [_button setBordered:NO];

    NSString *imagePath;
    // registerBtn
    imagePath = [[NSBundle mainBundle] pathForResource:@"Plus" ofType:@"tif"];
    NSImage *registerBtnImage = [[NSImage alloc]initByReferencingFile:imagePath];
    [_registerBtn setImage:registerBtnImage];
    
    // infoBtn
    imagePath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"tif"];
    NSImage *infoBtnImage = [[NSImage alloc]initByReferencingFile:imagePath];
    [_infoBtn setImage:infoBtnImage];
    
    // deleteBtn
    imagePath = [[NSBundle mainBundle] pathForResource:@"Block" ofType:@"tif"];
    NSImage *deleteBtnImage = [[NSImage alloc]initByReferencingFile:imagePath];
    [_deleteBtn setImage:deleteBtnImage];

}


-(IBAction)changeBtnImage:(id)sender{
    NSImage *image = [self createImage];
    [_button setImage:image];
    [self changeLabel];
}

-(void)changeLabel{
    NSDate *now = [NSDate new];
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    NSInteger seconds = [tz secondsFromGMTForDate: now];
    [_timeLabel setStringValue:[NSDate dateWithTimeInterval: seconds sinceDate: now]];
    
}

-(NSImage*)createImage{
    NSString *file;
    if(_imageFlag){
//        file = @"/Users/AirMyac/github/lab/ViewTest3/ViewTest3/clear.png";
        file = @"/Users/AirMyac/Desktop/image/image/Play.tif";
        _imageFlag = false;
    }else{
//        file = @"/Users/AirMyac/github/lab/ViewTest3/ViewTest3/ng.png";
        file = @"/Users/AirMyac/Desktop/image/image/Pause.tif";
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
        if((i % 3) == 0){
            model.type = @"skype";
        }else{
            model.type = @"finder";
        }
        model.name = @"hoge adga gadg gadg";
        NSDate *now = [NSDate new];
        NSTimeZone *tz = [NSTimeZone defaultTimeZone];
        NSInteger seconds = [tz secondsFromGMTForDate: now];
        NSString *time = [NSDate dateWithTimeInterval: seconds sinceDate: now];
        NSLog(@"%@", time);
        model.executed = time;
        model.note = time;
        [objects addObject:model];
    }
    [_arrayController setContent:objects];
    
}


@end
