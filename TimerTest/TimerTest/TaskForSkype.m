//
//  TaskForSkype.m
//  TimerTest
//
//  Created by AirMyac on 5/31/13.
//  Copyright (c) 2013 com.katzlifehack. All rights reserved.
//

#import "TaskForSkype.h"

@implementation TaskForSkype


/*
 * タスクの実行判定
 */
- (BOOL) check {
    return YES;
}


/*
 * タスクの処理内容
 */
- (void) execute {
 
    // SkypeのMessageを取得
    NSString *sql = @"select from_dispname, datetime(timestamp,\"unixepoch\",\"localtime\") as datetime, body_xml from messages where convo_id = (select conv_dbid from chats where participants = 'katsuhide1982 monji.takuro');";
    NSMutableArray *result = [self getSkypeMessages:sql];
    for(NSDictionary *dic in result){
        NSLog(@"name:%@, datetime:%@, body:%@", [dic objectForKey:@"name"], [dic objectForKey:@"datetime"], [dic objectForKey:@"body"]);
    }
    
    // EDAMNoteを作成し、Evernoteに保存

    
    
}


/*
 * SkypeにDBに接続してChat Messageを取得する
 */
- (NSMutableArray*)getSkypeMessages:(NSString*)sql{
    // DB設定情報
    NSString *databaseName = @"main.db";
    NSString *path = @"/Users/AirMyac/Library/Application Support/Skype/katsuhide1982";
    NSString *databasePath = [path stringByAppendingPathComponent:databaseName];
    FMDatabase *db  = [FMDatabase databaseWithPath:databasePath];
    
    // Open DB
    [db open];
    
    // Execute Query
    FMResultSet *results = [db executeQuery:sql];
    
    // Output
    NSMutableArray *result = [NSMutableArray array];
    while ([results next]) {
        NSArray *key = [NSArray arrayWithObjects:@"name", @"datetime", @"body", nil];
        NSArray *value = [NSArray arrayWithObjects:[results stringForColumn:@"from_dispname"], [results stringForColumn:@"datetime"], [results stringForColumn:@"body_xml"], nil];
        NSDictionary *dic = [NSDictionary dictionaryWithObjects:value forKeys:key];
        [result addObject:dic];
    }
    
    // Release result set
    [results close];
    
    // Close DB
    [db close];
    
    return result;
    
}


- (NSMutableArray*)getParticipants {

    // Query
    NSString *sql = @"select distinct participants from chats;";

    return nil;
    
}

@end
