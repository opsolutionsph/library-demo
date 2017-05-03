//
//  UserDBService.h
//  Suites
//
//  Created by OPS on 27/12/2016.
//  Copyright © 2016 OPS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CouchbaseLite/CouchbaseLite.h>

@class UserModel;
@class UserDomain;

@interface UserDBService : NSObject

+ (UserDBService *)sharedInstance;

- (NSString *)save:(UserModel *)data;
- (UserModel *)getUserModelData;
- (UserDomain *)getUserDomainData;
- (BOOL)isUserTeamValid:(NSString *)teamId withUsername:(NSString *)username;

@end
