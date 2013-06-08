//
//  ViewDataModel.m
//  ViewTest
//
//  Created by AirMyac on 6/8/13.
//  Copyright (c) 2013 com.katzlifehack. All rights reserved.
//

#import "ViewDataModel.h"

@implementation ViewDataModel

-(NSString*)getName{
    NSString *str = [NSString stringWithFormat:@"1:%@, 2:%@ ,3:%@", [self.name objectAtIndex:1], self.hoge, self.fuga];
    return str;
}
@end
