//
//  ProductDomain.h
//  Suites
//
//  Created by OPS on 11/01/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CouchbaseLite/CouchbaseLite.h>

@interface ProductDomain : NSObject

@property NSString *id;
@property NSString *team;
@property NSString *docType;
@property NSString *type;
@property NSArray *channels;

@property NSString *name;
@property NSNumber *price;

@property NSString *brandName;
@property NSString *details;

@property NSString *imageFilename;
@property NSNumber *inStock;

@property NSString *productDescription;
@property NSString *specification;
@property NSArray *tags;


- (id)initData:(CBLJSONDict *)data;

@end
