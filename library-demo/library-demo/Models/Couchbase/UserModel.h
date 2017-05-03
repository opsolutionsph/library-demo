//
//  UserModel.h
//  Suites
//
//  Created by OPS on 27/12/2016.
//  Copyright © 2016 OPS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CouchbaseLite/CouchbaseLite.h>

@interface UserModel : CBLModel

- (NSString *)type;
@property NSString *id;

@property (copy) NSArray *channels;
+ (Class) channelsItemClass;

@property NSArray *teams;
+ (Class) teamsItemClass;
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

@end
