//
//  UserModel.m
//  Suites
//
//  Created by OPS on 27/12/2016.
//  Copyright © 2016 OPS. All rights reserved.
//

#import "UserModel.h"
#import "ModelConstants.h"

@implementation UserModel

//- (id)init {
//    return self;
//}

- (NSString *)type {
    return DOC_TYPE_USER;
}
@dynamic id;
@dynamic channels;
+ (Class) channelsItemClass {
    return [NSString class];
}

@dynamic teams;
+ (Class) teamsItemClass {
    return [NSString class];
}
@dynamic currentTeamId;

@dynamic firstName;
@dynamic lastName;
@dynamic phoneNumber;
@dynamic mobileNumber;
@dynamic photoUrl; // required for AMI
@dynamic email;
@dynamic username;
@dynamic roleTitle;
@dynamic roleDescription;
@dynamic dateCreated;
@dynamic dateUpdated;

@end
