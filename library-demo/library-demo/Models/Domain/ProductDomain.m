//
//  ProductDomain.m
//  Suites
//
//  Created by OPS on 11/01/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

#import "ProductDomain.h"

@implementation ProductDomain

- (id)initData:(CBLJSONDict *)data {
    
    self.id = data[@"_id"];
    self.team = data[@"team"];
    self.type = data[@"type"];
    self.docType = data[@"docType"];
    self.channels = data[@"channels"];

    self.name = data[@"name"];
   	self.price = data[@"price"];
    
    self.brandName = data[@"brandName"];
    self.details = data[@"details"];
    
    self.imageFilename = data[@"imageFilename"];
    self.inStock = data[@"inStock"];

    self.productDescription = data[@"productDescription"];
    self.specification = data[@"specification"];
    self.tags = data[@"tags"];

    return self;
}

@end
