//
//  Notebook.h
//  CoreDataTest
//
//  Created by AirMyac on 6/3/13.
//  Copyright (c) 2013 com.katzlifehack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Notebook : NSManagedObject

@property (nonatomic, retain) NSString * guid;
@property (nonatomic, retain) NSString * name;

-(void)print;

@end
