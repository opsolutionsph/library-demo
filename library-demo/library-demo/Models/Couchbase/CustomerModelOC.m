//
//  CustomerModelOC.m
//  Suites
//
//  Created by OPS on 03/01/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

#import "CustomerModelOC.h"
#import "ModelConstants.h"
#import "OrderModel.h"

@implementation CustomerModelOC

@dynamic id;
@dynamic docType;
@dynamic team;

@dynamic channels;
+ (Class) channelsItemClass {
    return [NSString class];
}

@dynamic name;
@dynamic email;
@dynamic phone;
@dynamic address;

@dynamic appointmentId;

@dynamic primaryName;
@dynamic primaryEmail;
@dynamic primaryPhone;
@dynamic primaryAppoinmentDate;

@dynamic secondaryName;
@dynamic secondaryEmail;
@dynamic secondaryPhone;
@dynamic secondaryAppoinmentDate;

@dynamic cType;

@dynamic tags;
@dynamic notesReminders;

@dynamic cardType;
@dynamic cardNumber;

@dynamic csID;
@dynamic dateOpen;

@dynamic opening;

@dynamic status;

@dynamic approved;

- (NSString *)type {
    return DOC_TYPE_CUSTOMER;
}

// TODO: Trial and Error of Kat 02202017
@dynamic orders;
+ (Class) ordersItemClass { return [OrderModel class]; }
+ (NSString*) ordersInverseRelation { return @"customer"; }

@end
