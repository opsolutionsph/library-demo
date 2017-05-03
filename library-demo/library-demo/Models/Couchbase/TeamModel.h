//
//  TeamModel.h
//  Suites
//
//  Created by OPS on 21/02/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CouchbaseLite/CouchbaseLite.h>

@interface TeamModel : CBLModel

+ (NSString *)type;
@property NSString *id;
@property (copy) NSArray *channels;
+ (Class) channelsItemClass;

@property NSString *teamName;
@property NSString *teamDomain;

@end
