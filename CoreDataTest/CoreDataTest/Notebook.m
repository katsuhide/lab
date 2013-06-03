//
//  Notebook.m
//  CoreDataTest
//
//  Created by AirMyac on 6/3/13.
//  Copyright (c) 2013 com.katzlifehack. All rights reserved.
//

#import "Notebook.h"


@implementation Notebook

@dynamic guid;
@dynamic name;

-(void)print{
    NSLog(@"{\n"
          "\tnotebook_guid:%@\n"
          "\tnotebook_name:%@\n}",
          self.guid, self.name);
}

@end
