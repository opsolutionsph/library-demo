//
//  CustomerDBServiceOC.m
//  Suites
//
//  Created by OPS on 03/01/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

#import "CustomerDBServiceOC.h"

#import "CouchDBManagerOC.h"
#import "CustomerModelOC.h"
#import "CustomerDomainOC.h"


@interface CustomerDBServiceOC ()
@property (retain, nullable) CBLDatabase *database;
@property (nonatomic, strong) CustomerModelOC *customerModel;
@end

@implementation CustomerDBServiceOC

@synthesize database;
@synthesize customerModel;

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

+ (CustomerDBServiceOC *)sharedInstance {
    
    static CustomerDBServiceOC *sharedInstance = nil;
    
    if (sharedInstance == nil) {
        
        sharedInstance = [[CustomerDBServiceOC alloc] init];
    }
    
    return sharedInstance;
}

/**
 * Dynamic instantiation using Couchbase model factory
 */
- (void)registerCBLClass {
    self.customerModel = [CustomerModelOC alloc];
    CBLModelFactory *factory = self.database.modelFactory;

    [factory registerClass:[self.customerModel class] forDocumentType:[self.customerModel type]];
}

#pragma mark - create

/**
 Create a new document with type and documentID properties
 @returns CustomerModelOC
 */
- (CustomerModelOC *)createInstance {
    CustomerModelOC *customer = [CustomerModelOC modelForNewDocumentInDatabase:self.database];

    NSError *error;
    BOOL isSuccess = [customer save:&error];
    
    if (isSuccess) {
        return customer;
    }
    
    return nil;
}

#pragma mark - update

/**
 Update the Model
 @returns String documentID
 @param data An NSDictionary of the Model attributes
 */

- (NSString *)update:(CustomerModelOC *)data {
    
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
    NSString *type = [self.customerModel type];
    NSString *viewName = [type stringByAppendingString: @"findAll"];

    CBLView *view = [self.database viewNamed: viewName];
    [view setMapBlock: MAPBLOCK({
        
        if ([doc[@"type"] isEqual: [self.customerModel type]]) {
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
        [data addObject: [[CustomerDomainOC alloc]initData:row.documentProperties]];
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
