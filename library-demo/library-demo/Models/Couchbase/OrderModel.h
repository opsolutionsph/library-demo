//
//  OrderModel.h
//  Suites
//
//  Created by OPS on 16/02/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

#import <CouchbaseLite/CouchbaseLite.h>
#import <CouchbaseLite/CouchbaseLite.h>

#import "CustomerModelOC.h"

@interface OrderModel : CBLModel

+ (NSString *)type;
@property NSString *id;
@property (copy) NSArray *channels;
+ (Class) channelsItemClass;

@property (copy) NSArray *orderedProducts; // array of json
+ (Class) orderedProductsItemClass;
// productID
// * quantity
// * price
// * subTotalPrice
// ** sampling
// productRating
// feedback
// dateOfFeedback

@property NSNumber *totalPrice;
@property NSDate *dateOrdered;
@property NSDate *dateShipped;

// TODO: Trial and Error of Kat 02202017
@property NSString* customerID;

@end
