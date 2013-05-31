//
//  IEAppDelegate.m
//  TimerTest
//
//  Created by AirMyac on 5/31/13.
//  Copyright (c) 2013 com.katzlifehack. All rights reserved.
//

#import "IEAppDelegate.h"

@implementation IEAppDelegate

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application

    // DB設定情報
    NSString *databaseName = @"main.db";
    NSString *path = @"/Users/AirMyac/Library/Application Support/Skype/katsuhide1982";
    NSString *databasePath = [path stringByAppendingPathComponent:databaseName];
    FMDatabase *db  = [FMDatabase databaseWithPath:databasePath];
    // Query
    NSString *sql = @"select distinct participants from chats;";

    // Open DB
    [db open];
    // Execute Query
    FMResultSet *results = [db executeQuery:sql];
    
    // Output
    while ([results next]) {
        NSLog(@"%@", [results stringForColumn:@"participants"]);
    }
    
    // Release result set
    [results close];
    
    sql = @"select from_dispname, datetime(timestamp,\"unixepoch\",\"localtime\") as datetime, body_xml from messages where convo_id = (select conv_dbid from chats where participants = 'katsuhide1982 monji.takuro reqotan yota_sato');";
    results = [db executeQuery:sql];
    while ([results next]) {
        NSLog(@"%@, %@, %@", [results stringForColumn:@"from_dispname"], [results stringForColumn:@"datetime"], [results stringForColumn:@"body_xml"]);
    }

    // Close DB
    [db close];
    

}

/*
 *
 */
- (void)run{
    // Create the Timer
    NSNumber *number = [[NSNumber alloc] initWithInt:1];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:number forKey:@"count"];
    NSTimer *timer = [NSTimer
                      scheduledTimerWithTimeInterval:3.f
                      target:self
                      selector:@selector(polling:)
                      userInfo:dic
                      repeats:YES];
    
}

// Polling処理
- (void)polling: (NSTimer*)timer{
    
    NSNumber *number = [[timer userInfo] objectForKey:@"count"];
    NSLog(@"count up:%@", number);
    int sum = [number intValue];
    sum = sum + 1;
    [[timer userInfo] setObject:[[NSNumber alloc]initWithInt:sum] forKey:@"count"];
    
}

// task test
- (void)taskTest{
    Task *task;
    task = [[Task alloc] initWith:@"2012"];
    [task execute];
    task = [[TaskForSkype alloc] initWith:@"2013"];
    [task execute];
    task = [[TaskForFile alloc]init];
    [task execute];
    
}


@end
