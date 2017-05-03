//
//  CustomerDomainOC.h
//  Suites
//
//  Created by OPS on 04/01/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CouchbaseLite/CouchbaseLite.h>

@interface CustomerDomainOC : NSObject

@property NSString *id;
@property NSString *docType;
@property NSString *team;
@property NSArray *channels;

@property NSString *name;
@property NSString *email;
@property NSString *phone;
@property NSString *address;
@property NSString *appointmentId;
@property NSString *cType;

@property NSString *primaryName;
@property NSString *primaryEmail;
@property NSString *primaryPhone;
@property NSDate *primaryAppoinmentDate;

@property NSString *secondaryName;
@property NSString *secondaryEmail;
@property NSString *secondaryPhone;
@property NSDate *secondaryAppoinmentDate;

@property NSString *tags;
@property NSString *notesReminders;

@property NSNumber *cardType;
@property NSString *cardNumber;

@property NSString *csID;
@property NSString *dateOpen;

@property NSString *opening;

@property NSString *status;
@property BOOL approved;

- (id)initData:(CBLJSONDict *)data;

@end
