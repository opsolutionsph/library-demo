//
//  ProductDomainOC.m
//  Suites
//
//  Created by OPS on 11/01/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

#import "ProductDomainOC.h"

@implementation ProductDomainOC

- (id)initData:(CBLJSONDict *)data {
    
    self.id = data[@"id"];
    self.productName = data[@"productName"];
    self.price = data[@"price"];
    self.channels = data[@"channels"];
    
    return self;
}

@end
