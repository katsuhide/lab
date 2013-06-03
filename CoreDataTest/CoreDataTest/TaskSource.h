//
//  TaskSource.h
//  CoreDataTest
//
//  Created by AirMyac on 6/3/13.
//  Copyright (c) 2013 com.katzlifehack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Notebook;

@interface TaskSource : NSManagedObject

@property (nonatomic, retain) NSString * task_name;
@property (nonatomic, retain) NSNumber * interval;
@property (nonatomic, retain) NSDate * last_execute_time;
@property (nonatomic, retain) NSString * note_title;
@property (nonatomic, retain) NSString * tag;
@property (nonatomic, retain) NSString * params;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) Notebook *notebook;

@end
