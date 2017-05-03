//
//  SettingsDomain.h
//  Suites
//
//  Created by OPS on 11/01/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CouchbaseLite/CouchbaseLite.h>

@interface SettingsDomainOC : NSObject

@property NSString *id;
@property NSString *setTeam;
@property NSArray *channels;

@property NSString *setName;
@property NSString *setEmail;
@property NSString *setPhone;
@property NSString *setAddress;

- (id)initData:(CBLJSONDict *)data;

@end
