//
//  UserDomain.h
//  Suites
//
//  Created by OPS on 14/02/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CouchbaseLite/CouchbaseLite.h>

@interface UserDomain : NSObject

@property NSString *type;
@property NSString *id;
@property NSArray *channels;
@property NSArray *teams;

@property NSString *currentTeamId;

@property NSString *firstName;
@property NSString *lastName;
@property NSString *phoneNumber;
@property NSString *mobileNumber;
@property NSString *photoUrl; // required for AMI
@property NSString *email;
@property NSString *username;
@property NSString *roleTitle;
@property NSString *roleDescription;
@property NSDate *dateCreated;
@property NSDate *dateUpdated;

- (id)initData:(CBLJSONDict *)data;

@end
