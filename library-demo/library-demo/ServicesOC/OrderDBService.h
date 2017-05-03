//
//  OrderDBService.h
//  Suites
//
//  Created by OPS on 16/02/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CouchbaseLite/CouchbaseLite.h>

//#import "BaseDBServiceProtocol.h"

@class OrderModel;
@class OrderDomain;

@interface OrderDBService : NSObject// <BaseDBServiceProtocol>

- (OrderDomain *)findDocument:(NSString *)documentId;
- (NSDictionary *)save:(OrderDomain *)data;
- (NSArray *)listOrdersForFeedbackByCustomerId:(NSString *)customerID; // Array of OrderDomain

@end
