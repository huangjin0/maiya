//
//  DBConnection.h
//  TwitterFon
//
//  Created by kaz on 12/21/08.
//  Copyright 2008 naan studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Statement.h"

#define MAIN_DATABASE_NAME @"MyDatabase.sqlite"

//
// Interface for Database connector
//
@interface DBConnection : NSObject
{
}

+ (void)createEditableCopyOfDatabaseIfNeeded:(BOOL)force;
+ (void)deleteMessageCache;

+ (sqlite3*)getSharedDatabase;
+ (void)closeDatabase;

+ (void)beginTransaction;
+ (void)commitTransaction;

+ (Statement*)statementWithQuery:(const char*)sql;

+ (void)alert;

@end