//
//  UserDomain.m
//  Suites
//
//  Created by OPS on 14/02/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

#import "UserDomain.h"

@implementation UserDomain

- (id)initData:(CBLJSONDict *)data {

    self.type = data[@"type"];
    self.id = data[@"_id"];
    self.channels = data[@"channels"];
    self.teams = data[@"teams"];

    self.currentTeamId = data[@"currentTeamId"];

    self.firstName = data[@"firstName"];
    self.lastName = data[@"lastName"];
    self.phoneNumber = data[@"phoneNumber"];
    self.mobileNumber = data[@"mobileNumber"];
    self.photoUrl = data[@"photoUrl"];
    self.email = data[@"email"];
    self.username = data[@"username"];
    self.roleTitle = data[@"roleTitle"];
    self.roleDescription = data[@"roleDescription"];
    self.dateCreated = data[@"dateCreated"];
    self.dateUpdated = data[@"dateUpdated"];
    
    return self;
}

@end
