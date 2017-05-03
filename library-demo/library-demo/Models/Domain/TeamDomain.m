//
//  TeamDomain.m
//  Suites
//
//  Created by OPS on 21/02/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

#import "TeamDomain.h"

@implementation TeamDomain

- (id)initData:(nullable NSDictionary *)data {
    
    self.type = data[@"type"];
    self.id = data[@"_id"];
    self.channels = data[@"channels"];
    
    self.teamName = data[@"teamName"];
    self.teamDomain = data[@"teamDomain"];

    return self;
}

@end
