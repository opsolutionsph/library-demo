//
//  ProductDBService.h
//  Suites
//
//  Created by OPS on 11/01/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CouchbaseLite/CouchbaseLite.h>

@class ProductModel;
@class ProductDomain;

@interface ProductDBService : NSObject

//- (id)initModel:(CBLDatabase *)sharedDatabase;

+(ProductDBService *) sharedInstance;

- (ProductModel *)createInstance;
- (NSString *)update:(ProductModel*)data;
- (NSMutableArray *)listAll;
- (NSDictionary *)findById:(NSString *)id;
- (NSMutableArray *)search:(NSArray *)tags;

- (void)customAutoSync;
@end
