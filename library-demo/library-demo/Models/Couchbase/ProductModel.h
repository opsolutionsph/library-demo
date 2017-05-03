//
//  ProductModel.h
//  Suites
//
//  Created by OPS on 11/01/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CouchbaseLite/CouchbaseLite.h>

@interface ProductModel : CBLModel

@property NSString *id;
@property NSString *team;
@property NSString *docType;
@property (copy) NSArray *channels;

+ (Class) channelsItemClass;
- (NSString *)type;

@property NSString *name;
@property NSNumber *price;

@property NSString *brandName;
@property NSString *details;

@property NSString *imageFilename;


@property NSNumber *inStock;

@property NSString *productCode;
@property NSString *productDescription;
@property NSString *sku;
@property NSString *specification;

@property (copy) NSArray *tags;
+ (Class) tagsItemClass;

@end
