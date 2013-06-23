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
    
    NSString *file;
    if((self.status % 2) == 0){
        file = [[NSBundle mainBundle] pathForResource:@"Play" ofType:@"tif"];
    }else{
        file = [[NSBundle mainBundle] pathForResource:@"Pause" ofType:@"tif"];
    }
    NSImage *image = [[NSImage alloc]initByReferencingFile:file];
    return image;
}

-(NSImage*)getTypeImage{
    
    NSString *file;
    if([self.type isEqualToString:@"skype"]){
        file = [[NSBundle mainBundle] pathForResource:@"skype" ofType:@"png"];
    }else{
        file = [[NSBundle mainBundle] pathForResource:@"documents_folder" ofType:@"png"];
    }
    NSImage *image = [[NSImage alloc]initByReferencingFile:file];
    return image;
}


@end
