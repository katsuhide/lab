//
//  Bug.h
//  ScaryBugsApp
//
//  Created by AirMyac on 6/4/13.
//  Copyright (c) 2013 Ray Wenderlich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Bug : NSManagedObject

@property (nonatomic, retain) NSString * imagePath;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * rating;

@end
