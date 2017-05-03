//
//  OrderDomain.h
//  Suites
//
//  Created by OPS on 16/02/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CouchbaseLite/CouchbaseLite.h>

@interface OrderDomain : NSObject

@property NSString *type;
@property NSString *id;
@property NSArray *channels;

@property NSArray *orderedProducts; // array of json

@property NSNumber *totalPrice;
@property NSDate *dateOrdered;
@property NSDate *dateShipped;

- (id)initData:(CBLJSONDict *)data;

// TODO: Trial and Error of Kat 02202017
@property NSString* customerID;

@end
