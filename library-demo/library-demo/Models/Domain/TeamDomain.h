//
//  TeamDomain.h
//  Suites
//
//  Created by OPS on 21/02/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CouchbaseLite/CouchbaseLite.h>

@interface TeamDomain : NSObject

@property NSString *type;
@property NSString *id;
@property NSArray *channels;

@property NSString *teamName;
@property NSString *teamDomain;

- (id)initData:(CBLJSONDict *)data;

@end
