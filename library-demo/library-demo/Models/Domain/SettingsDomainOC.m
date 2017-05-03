//
//  SettingsDomain.m
//  Suites
//
//  Created by OPS on 11/01/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

#import "SettingsDomainOC.h"

@implementation SettingsDomainOC

- (id)initData:(CBLJSONDict *)data {
    
    self.id = data[@"id"];
    self.setTeam = data[@"setTeam"];
    self.channels = data[@"channels"];
    
    self.setName = data[@"setName"];
    self.setEmail = data[@"setEmail"];
    self.setPhone = data[@"setPhone"];
    self.setAddress = data[@"setAddress"];

    return self;
}

@end
