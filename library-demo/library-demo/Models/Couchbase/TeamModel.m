//
//  TeamModel.m
//  Suites
//
//  Created by OPS on 21/02/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

#import "TeamModel.h"
#import "ModelConstants.h"

@implementation TeamModel

+ (NSString *)type {
    return DOC_TYPE_TEAM;
}
@dynamic id;
@dynamic channels;
+ (Class) channelsItemClass {
    return [NSString class];
}

@dynamic teamName;
@dynamic teamDomain;

@end
