//
//  OrderDomain.m
//  Suites
//
//  Created by OPS on 16/02/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

#import "OrderDomain.h"

@implementation OrderDomain

- (id)initData:(nullable NSDictionary *)data {
    
    self.type = data[@"type"];
    self.id = data[@"_id"];
    self.channels = data[@"channels"];

    self.orderedProducts = data[@"orderedProducts"]; // array of json
    self.totalPrice = data[@"totalPrice"];
    self.dateOrdered = data[@"dateOrdered"];
    self.dateShipped = data[@"dateShipped"];
//NSLog(@"\n\n\norderedProducts:: %@", data[@"orderedProducts"]);
//    NSLog(@"\n\n\ndateOrdered:: %@", data[@"dateOrdered"]);

    // TODO: Trial and Error of Kat 02202017
    self.customerID = data[@"customerID"];

    return self;
}

@end
