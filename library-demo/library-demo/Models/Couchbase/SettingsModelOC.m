//
//  SettingsModelOC.m
//  Suites
//
//  Created by OPS on 11/01/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

#import "SettingsModelOC.h"
#import "ModelConstants.h"

@implementation SettingsModelOC

@dynamic id;
@dynamic setTeam;
@dynamic setName;
@dynamic setEmail;
@dynamic setPhone;
@dynamic setAddress;

@dynamic channels;
+ (Class) channelsItemClass {
    return [NSString class];
}

- (NSString *)type {
    return DOC_TYPE_SETTINGS;
}

@end
