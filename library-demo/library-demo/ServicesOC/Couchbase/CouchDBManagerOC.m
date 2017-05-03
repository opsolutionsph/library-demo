//
//  CouchDBManagerOC.m
//  Suites
//
//  Created by OPS on 27/12/2016.
//  Copyright © 2016 OPS. All rights reserved.
//

#import "CouchDBManagerOC.h"
#import "KeyChainWrapper.h"
#import <CouchbaseLite/CouchbaseLite.h>

@implementation CouchDBManagerOC

static CouchDBManagerOC *sharedInstance = nil;


+ (CouchDBManagerOC *)sharedInstance {

    if (sharedInstance == nil) {

        sharedInstance = [[CouchDBManagerOC alloc] init];
    }

    return sharedInstance;
}

+ (void) destroyObject {
    sharedInstance = nil;
}

- (id)init {
    
    self = [super init];
    
    if (self) {
        
        NSError *error;
        CBLManagerOptions options = {NO, NSDataWritingFileProtectionCompleteUntilFirstUserAuthentication};
        self.manager = [[CBLManager alloc] initWithDirectory: [CBLManager defaultDirectory] options: &options error: &error];

        if (!self.manager) {
            return nil;
        }

        NSString *username = [[KeyChainWrapper sharedInstance]getUsername];

        // keychain:username+password+session must only be filled out via valid SG authentication
        // if username not empty/nil, that means, the user is a valid SG user

        if (username.length > 0) {
            NSString *password = [[KeyChainWrapper sharedInstance]getPassword];
            return [self initDatabase:username password:password create:YES newPassword:nil];
        }
    }

    return self;
}

- (id)initDatabase:(NSString *)username password:(NSString *)password create:(BOOL)create newPassword:(nullable NSString *)newPassword {

    self = [super init];

    if (self) {

        // Since this part will only be called every time the username variable is not empty,
        // database will ONLY be created if the user is validated via SG

        NSError *error;
        NSString *formattedUsername = [username lowercaseString];
        
        CBLDatabaseOptions *options = [[CBLDatabaseOptions alloc] init];
        options.encryptionKey = password;
        options.create = create; // create database if it does not exist

        self.database = [self.manager openDatabaseNamed:formattedUsername withOptions:options error:&error];

        if (newPassword.length > 0) {
            NSLog(@"OMG NIL sya???");
            [self.database changeEncryptionKey: newPassword error:&error];
        }
    
        if (self.database) {
            return self;
        } else {
            self.errorMessage = [[NSMutableDictionary alloc]init];
            [self.errorMessage setValue:[NSNumber numberWithInteger:error.code] forKey:@"code"];
            [self.errorMessage setValue:@"Error" forKey:@"errorTitle"];
            [self.errorMessage setValue:error.localizedDescription forKey:@"errorMessage"];
            
            NSLog(@"Cannot create database. Error code: %tu", error.code);
            NSLog(@"Cannot create database. Error message: %@", error.localizedDescription);

            // TODO: Log error messages for easy debugging
        }
    }
    
    return self;
}

- (BOOL)validateUser:(NSString *)username password:(NSString *)password {

    NSString *formattedUsername = [username lowercaseString];

    CBLDatabaseOptions *options = [[CBLDatabaseOptions alloc] init];
    options.encryptionKey = password;
    options.create = NO; // make sure that no database will be created

    NSError *error;

    self.database = [self.manager openDatabaseNamed:formattedUsername withOptions:options error:&error];

    if (self.database) {
        return YES;
    } else {

        NSLog(@"VALIDATION: Cannot create database. Error code: %tu", error.code);
        NSLog(@"VALIDATION: Cannot create database. Error message: %@", error.localizedDescription);

        // TODO: Log error messages for easy debugging

        return NO;
    }
}

- (NSString *)generateUUID:(NSString *)documentType {
    NSString *stringUuid = [[NSUUID UUID] UUIDString];
    NSString *modelType = [documentType uppercaseString];
    NSString *strType = [modelType stringByAppendingString:@"::"];
    NSString *uuid = [strType stringByAppendingString:stringUuid];
    
    return uuid;
}

- (void)printAllDocuments {
    CBLQuery *query = [self.database createAllDocumentsQuery];
    query.prefetch = YES;
    query.allDocsMode = kCBLAllDocs;
    
    NSError *error;
    CBLQueryEnumerator* result = [query run: &error];
    NSLog(@"\n\n\n");
    for (CBLQueryRow* row in result) {
        NSLog(@"\nALLDOCS:: %@", row.documentProperties);
        NSLog(@"\n\n");
    }
}

// for testing purposes only
- (void)deleteDatabase {
    NSError* error;
    
    if (![self.database deleteDatabase: &error]) {
        NSLog(@"DB deleted!");
    }
    
    self.database = nil;
}

@end
