//
//  CustomerModelOC.h
//  Suites
//
//  Created by OPS on 03/01/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CouchbaseLite/CouchbaseLite.h>

@interface CustomerModelOC : CBLModel
@property NSString *id;
@property NSString *docType;
@property NSString *team;
@property (copy) NSArray *channels;
+ (Class) channelsItemClass;

@property NSString *name;
@property NSString *email;
@property NSString *phone;
@property NSString *address;

@property NSString *appointmentId;
@property NSString *primaryName;
@property NSString *primaryEmail;
@property NSString *primaryPhone;
@property NSDate *primaryAppoinmentDate;

@property NSString *secondaryName;
@property NSString *secondaryEmail;
@property NSString *secondaryPhone;
@property NSDate *secondaryAppoinmentDate;

@property NSString *cType; //customer type

@property NSString *tags;
@property NSString *notesReminders;

@property NSNumber *cardType;
@property NSString *cardNumber;

@property NSString *csID; // Client's customer ID on their system
@property NSString *dateOpen;

@property NSString *opening; // opening hour

/* Status
 Active - display
 Inactive - display
 Delisted - do not display
 */
@property NSString *status;

@property BOOL *approved;

- (NSString *)type;

// TODO: Trial and Error of Kat 02202017
@property (readonly) NSArray* orders;

@end
