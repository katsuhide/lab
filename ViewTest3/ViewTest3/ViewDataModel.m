//
//  ViewDataModel.m
//  ViewTest3
//
//  Created by AirMyac on 6/22/13.
//  Copyright (c) 2013 com.katzlifehack. All rights reserved.
//

#import "ViewDataModel.h"

@implementation ViewDataModel

-(NSImage*)getImageName{
    
//    NSString *file = @"/Users/AirMyac/github/lab/ViewTest3/ViewTest3/ng.png";
//    NSImage *image = [[NSImage alloc]initByReferencingFile:file];
//    NSString* path = [[NSBundle mainBundle] pathForResource:@"clear" ofType:@"png"];
//    NSLog(@"%@", path);
    
    NSString *file;
    if((self.status % 2) == 0){
//        file = @"/Users/AirMyac/github/lab/ViewTest3/ViewTest3/clear.png";
        file = [[NSBundle mainBundle] pathForResource:@"clear" ofType:@"png"];
    }else{
//        file = @"/Users/AirMyac/github/lab/ViewTest3/ViewTest3/ng.png";
        file = [[NSBundle mainBundle] pathForResource:@"ng" ofType:@"png"];
    }
    NSImage *image = [[NSImage alloc]initByReferencingFile:file];

    return image;
}

@end
