//
//  ProductDBService.m
//  Suites
//
//  Created by OPS on 11/01/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

#import "ProductDBService.h"
#import "CouchDBManagerOC.h"
#import "ProductModel.h"
#import "ProductDomain.h"


@interface ProductDBService ()
@property (retain, nullable) CBLDatabase *database;
@property (nonatomic, strong) ProductModel *productModel;
@end

@implementation ProductDBService

@synthesize database;
@synthesize productModel;

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

+ (ProductDBService *)sharedInstance {
    
    static ProductDBService *sharedInstance = nil;
    
    if (sharedInstance == nil) {
        sharedInstance = [[ProductDBService alloc] init];
    }
    
    return sharedInstance;
}

/**
 * Dynamic instantiation using Couchbase model factory
 */
- (void)registerCBLClass {
    self.productModel = [ProductModel alloc];
    CBLModelFactory *factory = self.database.modelFactory;
    
    [factory registerClass:[self.productModel class] forDocumentType:[self.productModel type]];
}

#pragma mark - create

/**
 Create a new document with type and documentID properties
 @returns ProductModel
 */
- (ProductModel *)createInstance {
    ProductModel *product = [ProductModel modelForNewDocumentInDatabase:self.database];
    
    NSError *error;
    BOOL isSuccess = [product save:&error];
    
    if (isSuccess) {
        return product;
    }
    
    return nil;
}

#pragma mark - update

/**
 Update the Model
 @returns String documentID
 @param data An NSDictionary of the Model attributes
 */

- (NSString *)update:(ProductModel *)data {
    
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

- (NSMutableArray *)listAll {
    NSString *type = [self.productModel type];
    NSString *viewName = [type stringByAppendingString: @"findAll"];
    
    CBLView *view = [self.database viewNamed: viewName];
    [view setMapBlock: MAPBLOCK({
        
        if ([doc[@"docType"] isEqual: [self.productModel type]]) {
            emit(doc[@"_id"], nil);
        }
    }) version: @"2"];
    
    CBLQuery* query = [[self.database viewNamed: viewName] createQuery];
    query.prefetch = YES;

    NSMutableArray *data = [[NSMutableArray alloc]init];
    
    NSError *error;
    CBLQueryEnumerator *result = [query run: &error];
    for (CBLQueryRow* row in result) {
        NSLog(@"DocProp:: %@", row.documentProperties);
        [data addObject: [[ProductDomain alloc]initData:row.documentProperties]];
    }
    
//    NSLog(@"DATA:: %@", data);
    return data;
}

- (NSDictionary *)findById:(NSString *)id {
    
    CBLDocument* doc = [database documentWithID: id];
    
    NSDictionary* properties = doc.properties;
    
    return properties;
}

// Temporary
- (void)customAutoSync {
    CBLDocument* doc = [database documentWithID: @"product-SamsungApp0000001"];
    NSMutableDictionary* property = [doc.properties mutableCopy];
    property[@"name"] = @"4-Door Flex sync-test:push";
    
    NSError* error;
    if (![doc putProperties: property error: &error]) {
        NSLog(@"\nUpdate succes\n");
    }
}

#pragma mark - search

- (NSMutableArray *)search:(NSArray *)tags {

    NSArray *select = @[@"name", @"sku", @"brandName", @"details", @"imageFilename", @"inStock", @"price",@"productCode",@"productDescription",@"sku",@"specification",@"tags"];

    NSPredicate *typePredicate = [NSPredicate predicateWithFormat:@"type == 'product'"];
    NSPredicate *tagsPredicate = [NSPredicate predicateWithFormat:@"tags contains $TAGS"];
    NSCompoundPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[typePredicate, tagsPredicate]];
    
    NSError *error = nil;

    CBLQueryBuilder *tagQueryBuilder = [[CBLQueryBuilder alloc] initWithDatabase: self.database
                                                                          select: select
                                                                  wherePredicate: predicate
                                                                         orderBy: nil
                                                                           error: &error];
    NSMutableArray *data = [[NSMutableArray alloc]init];

    for (NSString *tag in tags) {

        NSDictionary *context = @{@"TAGS": tag};
        CBLQueryEnumerator *queryObj  = [tagQueryBuilder runQueryWithContext: context error: &error];
    
        for (CBLQueryRow *row in queryObj) {
            [data addObject: [[ProductDomain alloc]initData:row.document.properties]];
        }
    }
    
    return data;
}

@end
