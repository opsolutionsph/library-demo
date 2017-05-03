//
//  UserDBService.m
//  Suites
//
//  Created by OPS on 27/12/2016.
//  Copyright © 2016 OPS. All rights reserved.
//

#import "UserDBService.h"
#import "CouchDBManagerOC.h"
#import "UserModel.h"
#import "UserDomain.h"
#import "KeyChainWrapper.h"

@interface UserDBService ()
    @property (retain, nullable) CBLDatabase *database;
    @property (nonatomic, strong) UserModel *userModel;
    @property (nonatomic, strong) NSString *username;
@end

@implementation UserDBService

@synthesize database;
@synthesize userModel;
@synthesize username;

static UserDBService *sharedInstance = nil;

- (id)init {
    
    self = [super init];
    
    if (self) {
        self.database = [[CouchDBManagerOC sharedInstance]database];
        self.userModel = [UserModel alloc];
        self.username = [[KeyChainWrapper sharedInstance]getUsername];
        [self registerCBLClass];
    }

    return self;
}

+ (UserDBService *)sharedInstance {
    
    if (sharedInstance == nil) {
        sharedInstance = [[UserDBService alloc] init];
    }
    
    return sharedInstance;
}

- (void)registerCBLClass {

    CBLModelFactory *factory = self.database.modelFactory;
    
    [factory registerClass:[self.userModel class] forDocumentType:[self.userModel type]];
}

/*
 * @returns The user Id on success.
 */
- (NSString *)save:(UserModel*)data {

    NSError *error;
    BOOL isSuccess = [data save:&error];
    
    if(isSuccess) {
        NSLog(@"DATA was saved:: %@", [[data document]properties]);
        return [[data document]documentID];
    } else {
        
        // TODO: Log error
        NSLog(@"Cannot save changes with error : %@", error);
        
        return nil;
    }
}

- (UserModel *)getUserModelData {
    
    CBLJSONDict *user = [self getUserProperties];
    CBLDocument *doc = [self.database documentWithID:user[@"_id"]];

    return [UserModel modelForDocument: doc];
}

- (UserDomain *)getUserDomainData {
    CBLJSONDict *userProperties = [self getUserProperties];
    
    return [[UserDomain alloc]initData:userProperties];
}

- (BOOL)isUserTeamValid:(NSString *)teamId withUsername:(NSString *)usernameParam {
    NSArray *select = @[@"id"];
    
    NSPredicate *typePredicate = [NSPredicate predicateWithFormat:@"type == 'user'"];
    NSPredicate *teamPredicate = [NSPredicate predicateWithFormat:@"teamId == $TEAMID"];
    NSPredicate *usernamePredicate = [NSPredicate predicateWithFormat:@"username == $USERNAME"];
    NSCompoundPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[typePredicate, teamPredicate, usernamePredicate]];
    
    NSError *error = nil;

    CBLQueryBuilder *tagQueryBuilder = [[CBLQueryBuilder alloc] initWithDatabase: self.database
                                                                          select: select
                                                                  wherePredicate: predicate
                                                                         orderBy: nil
                                                                           error: &error];
    
    NSDictionary *context = @{@"TEAMID": teamId, @"USERNAME" : usernameParam};
    CBLQueryEnumerator *queryObj  = [tagQueryBuilder runQueryWithContext: context error: &error];
    
    for (CBLQueryRow *row in queryObj) {
        NSLog(@"\n\n------------------\n\n");
        NSLog(@"KAT teamId:: %@", teamId);
        NSLog(@"ROW DOCID:: %@", row.document.properties[@"teamId"]);
        NSLog(@"\n\n");
        
        if ([teamId isEqual:row.document.properties[@"teamId"]]) {
            return YES;
        }
    }
    
    return NO;
}

- (CBLJSONDict *)getUserProperties {

    NSArray *selectField = @[@"_id"];
    
    NSPredicate *typePredicate = [NSPredicate predicateWithFormat:@"type == 'user'"];
    NSPredicate *usernamePredicate = [NSPredicate predicateWithFormat:@"username == $USERNAME"];
    //NSPredicate *currentTeamIdPredicate = [NSPredicate predicateWithFormat:@"currentTeamId == $currentTeamUUID"];
    
    NSCompoundPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[typePredicate, usernamePredicate]];
    
    NSError *error = nil;
    
    CBLQueryBuilder *tagQueryBuilder = [[CBLQueryBuilder alloc] initWithDatabase: self.database
                                                                          select: selectField
                                                                  wherePredicate: predicate
                                                                         orderBy: nil
                                                                           error: &error];
    
    NSDictionary *context = @{@"USERNAME": self.username};
    
    CBLQueryEnumerator *queryObj  = [tagQueryBuilder runQueryWithContext: context error: &error];

    // NSLog(@"\n\nDOCPROP allobj :: %@", queryObj.allObjects);
    
    for (CBLQueryRow *row in queryObj) {
        // NSLog(@"DOCPROP :: %@", row.document.properties);
        return row.document.properties;
    }
    
    return nil;
}

@end
