//
//  SettingsDBService.m
//  Suites
//
//  Created by OPS on 11/01/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

#import "SettingsDBService.h"

#import "CouchDBManagerOC.h"
#import "SettingsModelOC.h"
#import "SettingsDomainOC.h"

@interface SettingsDBService ()
@property (retain, nullable) CBLDatabase *database;
@property (nonatomic, strong) SettingsModelOC *settingsModel;
@end

@implementation SettingsDBService

@synthesize database;
@synthesize settingsModel;

/*
 * Initialize the following:
 *     self
 *     database
 *     register model factory
 * @returns The Service
 */
- (id)init {
    
    self = [super init];
    
    if (self) {
        self.database = [[CouchDBManagerOC sharedInstance]database];
        [self registerCBLClass];
    }
    
    return self;
}

+ (SettingsDBService *)sharedInstance {
    
    static SettingsDBService *sharedInstance = nil;
    
    if (sharedInstance == nil) {
        
        sharedInstance = [[SettingsDBService alloc] init];
    }
    
    return sharedInstance;
}

/**
 * Dynamic instantiation using Couchbase model factory
 */
- (void)registerCBLClass {
    self.settingsModel = [SettingsModelOC alloc];
    CBLModelFactory *factory = self.database.modelFactory;
    
    [factory registerClass:[self.settingsModel class] forDocumentType:[self.settingsModel type]];
}

#pragma mark - create

/**
 Create a new document with type and documentID properties
 @returns SettingsModelOC
 */
- (SettingsModelOC *)createInstance {
    SettingsModelOC *settings = [SettingsModelOC modelForNewDocumentInDatabase:self.database];
    
    NSError *error;
    BOOL isSuccess = [settings save:&error];
    
    if (isSuccess) {
        return settings;
    }
    
    return nil;
}

#pragma mark - update

/**
 Update the Model
 @returns String documentID
 @param data An NSDictionary of the Model attributes
 */

- (NSString *)update:(SettingsModelOC *)data {
    
    NSError *error;
    
    BOOL isSuccess = [data save:&error];
    
    if(isSuccess) {
        NSLog(@"DATA update:: %@", [[data document]properties]);
        return [[data document]documentID];
    } else {
        NSLog(@"Cannot save changes with error : %@", error);
        
        return nil;
    }
}

#pragma mark - read

- (NSMutableArray *)findAll {
    NSString *type = [self.settingsModel type];
    NSString *viewName = [type stringByAppendingString: @"findAll"];
    
    CBLView *view = [self.database viewNamed: viewName];
    [view setMapBlock: MAPBLOCK({
        
        if ([doc[@"type"] isEqual: [self.settingsModel type]]) {
            emit(doc[@"_id"], nil);
        }
    }) version: @"1"];
    
    CBLQuery* query = [[self.database viewNamed: viewName] createQuery];
    query.prefetch = YES;
    
    NSMutableArray *data = [[NSMutableArray alloc]init];
    
    NSError *error;
    CBLQueryEnumerator *result = [query run: &error];
    for (CBLQueryRow* row in result) {
        NSLog(@"DocProp:: %@", row.documentProperties);
        [data addObject: [[SettingsDomainOC alloc]initData:row.documentProperties]];
    }
    
    NSLog(@"DATA:: %@", data);
    return data;
}

- (NSDictionary *)findById:(NSString *)id {
    
    CBLDocument* doc = [database documentWithID: id];
    
    NSDictionary* properties = doc.properties;
    
    return properties;
}

@end
