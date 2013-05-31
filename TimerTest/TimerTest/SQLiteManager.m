//
//  SQLiteManager.m
//  TimerTest
//
//  Created by AirMyac on 6/1/13.
//  Copyright (c) 2013 com.katzlifehack. All rights reserved.
//

#import "SQLiteManager.h"

@implementation SQLiteManager

+ (void)handleDatabaseWithSql:(NSString *)sql
{
    
    NSString *databaseName = @"main.db";
    NSString *path = @"/Users/AirMyac/Library/Application Support/Skype/katsuhide1982";
    NSString *databasePath = [path stringByAppendingPathComponent:databaseName];
    
    NSLog(@"%@", databasePath);
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    // 文章フォルダにデータベースファイルが存在しているかを確認する
    if (![manager fileExistsAtPath:databasePath]) {
        NSLog(@"Database file does note exist.");
    } else {
        NSLog(@"Database file exist.");
    }
    
    sqlite3 *database;
    sqlite3_stmt *statement;
    
    // 文章フォルダに用意されたデータベースファイルを開く
    if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
        
        NSLog(@"sql:%@", sql);
        
        int result = sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL);
        
        // SQLite のコンパイルに失敗した場合
        if (result != SQLITE_OK) {
            NSLog(@"Failed to SQLite compile.");
            return ;
        }
        
        // SQL 文を実行し、結果が得られなくなるまで繰り返す
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            NSLog(@"%@", [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 0)]);

        }
        
        // データベースを閉じる
        sqlite3_close(database);
    } else {
        
        NSLog(@"Can't open database.");
    }

    
    return ;
}


@end
