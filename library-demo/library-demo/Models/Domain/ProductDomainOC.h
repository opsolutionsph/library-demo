//
//  ProductDomainOC.h
//  Suites
//
//  Created by OPS on 11/01/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CouchbaseLite/CouchbaseLite.h>

@interface ProductDomainOC : NSObject

@property NSString *id;
@property NSString *productName;
@property NSString *price;
@property NSArray *channels;

- (id)initData:(CBLJSONDict *)data;


@end
