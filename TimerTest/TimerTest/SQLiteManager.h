//
//  SQLiteManager.h
//  TimerTest
//
//  Created by AirMyac on 6/1/13.
//  Copyright (c) 2013 com.katzlifehack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface SQLiteManager : NSObject

+ (void)handleDatabaseWithSql:(NSString *)sql;

@end
