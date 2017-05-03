//
//  ProductModelOC.h
//  Suites
//
//  Created by OPS on 11/01/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CouchbaseLite/CouchbaseLite.h>

@interface ProductModelOC : CBLModel

@property NSString *id;
@property NSString *team;
@property (copy) NSArray *channels;

+ (Class) channelsItemClass;
- (NSString *)type;

@property NSString *name;
@property float price;

@property NSString *brandName;
@property NSString *details;

@property NSString *imageFilename;


@property NSInteger *inStock;

@property NSString *productCode;
@property NSString *productDescription;
@property NSString *sku;
@property NSString *specification;

@property NSString *tags;
+ (Class) tagsItemClass;

@end
