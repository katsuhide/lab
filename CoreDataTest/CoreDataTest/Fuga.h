//
//  Fuga.h
//  CoreDataTest
//
//  Created by AirMyac on 6/3/13.
//  Copyright (c) 2013 com.katzlifehack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Fuga : NSManagedObject

@property (nonatomic, retain) NSNumber * task_id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * date;

@end
