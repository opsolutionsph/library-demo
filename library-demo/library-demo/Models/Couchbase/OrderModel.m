//
//  OrderModel.m
//  Suites
//
//  Created by OPS on 16/02/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

#import "OrderModel.h"
#import "ModelConstants.h"

@implementation OrderModel

+ (NSString *)type {
    return DOC_TYPE_ORDER;
}
@dynamic id;
@dynamic channels;
+ (Class) channelsItemClass {
    return [NSString class];
}

@dynamic orderedProducts;
+ (Class) orderedProductsItemClass {
    return [NSMutableDictionary class];
}

@dynamic totalPrice;
@dynamic dateOrdered;
@dynamic dateShipped;

// TODO: Trial and Error of Kat 02202017
@dynamic customerID;

@end
