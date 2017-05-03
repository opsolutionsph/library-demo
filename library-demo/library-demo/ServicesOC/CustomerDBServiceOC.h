//
//  CustomerDBServiceOC.h
//  Suites
//
//  Created by OPS on 03/01/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CustomerModelOC;
@class CustomerDomainOC;

@interface CustomerDBServiceOC : NSObject

+(CustomerDBServiceOC *) sharedInstance;

- (CustomerModelOC *)createInstance;
- (NSString *)update:(CustomerModelOC*)data;
- (NSMutableArray *)findAll;
- (NSDictionary *)findById:(NSString *)id;

@end
