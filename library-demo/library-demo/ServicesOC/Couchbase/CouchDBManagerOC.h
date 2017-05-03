//
//  CouchDBManagerOC.h
//  Suites
//
//  Created by OPS on 27/12/2016.
//  Copyright © 2016 OPS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CBLManager;
@class CBLDatabase;
@class CBLDatabaseOptions;

// TODO: rename to DatabaseManager
@interface CouchDBManagerOC : NSObject

@property (nonatomic, strong) CBLDatabase *database;
@property (nonatomic, strong) CBLManager *manager;
@property (nonatomic, strong) NSMutableDictionary *errorMessage;

+(CouchDBManagerOC *) sharedInstance;
+ (void)destroyObject;

- (BOOL)validateUser:(NSString *)username password:(NSString *)password;
- (NSString *)generateUUID:(NSString *)documentType;

// for testing purposes only
- (void)printAllDocuments;
- (void)deleteDatabase;

@end
