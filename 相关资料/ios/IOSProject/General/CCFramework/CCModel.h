//
//  CCModel.h
//  CCFramework
//
//  Created by Kiwi on 10/13/14.
//  Copyright (c) 2014 Kiwi Private. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCModel : NSObject

// id for data object
@property (assign, nonatomic) NSInteger ID;
// head image URL for data object
@property (strong, nonatomic) NSString * headURL;

// getters only, return a json dictionary
@property (readonly, nonatomic) NSDictionary * dictionary;

// create an instance with json dictionary
+ (id)objectWithDictionary:(NSDictionary*)dic;

// create a table in Database
// -must be implemented in sub-classes
+ (void)createTableIfNotExists;

// initialize an instance with json dictionary
// -must be implemented in sub-classes
- (id)initWithDictionary:(NSDictionary*)dic;

// update an instance with json dictionary
// -must be implemented in sub-classes
- (void)updateWithDictionary:(NSDictionary*)dic;

// insert an instance in Database
// -must be implemented in sub-classes
- (void)insertDB;

@end
