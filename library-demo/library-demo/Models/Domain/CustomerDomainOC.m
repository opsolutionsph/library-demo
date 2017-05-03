//
//  CustomerDomainOC.m
//  Suites
//
//  Created by OPS on 04/01/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

#import "CustomerDomainOC.h"

@implementation CustomerDomainOC

- (id)initData:(CBLJSONDict *)data {

    self.id = data[@"id"];
    self.team = data[@"team"];
    self.channels = data[@"channels"];

    self.name = data[@"name"];
    self.email = data[@"email"];
    self.phone = data[@"phone"];
    self.address = data[@"address"];

    self.appointmentId = data[@"appointmentId"];
    self.primaryEmail = data[@"primaryEmail"];
    self.primaryName = data[@"primaryName"];
    self.primaryPhone = data[@"primaryPhone"];

    self.secondaryName = data[@"secondaryName"];
    self.secondaryEmail = data[@"secondaryEmail"];
    self.secondaryPhone = data[@"secondaryPhone"];
    self.secondaryAppoinmentDate = data[@"secondaryAppoinmentDate"];
    
    self.cType = data[@"cType"];
    
    self.tags = data[@"tags"];
    self.notesReminders = data[@"notesReminders"];

    self.cardType = data[@"cardType"];
    self.cardNumber = data[@"cardNumber"];

    self.csID = data[@"csID"];
    self.dateOpen = data[@"dateOpen"];
    
    self.opening = data[@"opening"];

    self.status = data[@"status"];

    self.approved = data[@"approved"];

    return self;
}

@end
