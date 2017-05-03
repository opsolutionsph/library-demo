//
//  ProductModelOC.m
//  Suites
//
//  Created by OPS on 11/01/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

#import "ProductModelOC.h"
#import "ModelConstants.h"

@implementation ProductModelOC

@dynamic id;
@dynamic name;
@dynamic price;

@dynamic channels;
+ (Class) channelsItemClass {
    return [NSString class];
}

- (NSString *)type {
    return DOC_TYPE_PRODUCT;
}
// --


@dynamic team;

@dynamic brandName;
@dynamic details;

@dynamic imageFilename;


@dynamic inStock;

@dynamic productCode;
@dynamic productDescription;
@dynamic sku;
@dynamic specification;

@dynamic tags;
+ (Class) tagsItemClass {
    return [NSString class];
}
@end
