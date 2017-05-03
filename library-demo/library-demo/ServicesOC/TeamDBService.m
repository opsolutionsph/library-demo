//
//  TeamDBService.m
//  Suites
//
//  Created by OPS on 21/02/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

#import "TeamDBService.h"
#import "TeamModel.h"
#import "TeamDomain.h"

#import "CouchDBManagerOC.h"

//#import "ProductDBService.h"
//#import "Suites-Swift.h"

@interface TeamDBService()
@property (nonatomic, strong) CouchDBManagerOC *databaseManager;
@property (nonatomic, strong) CBLDatabase *database;
@end

@implementation TeamDBService

@synthesize databaseManager;
@synthesize database;

# pragma Methods

- (id)init {
    
    self = [super init];
    
    if (self) {
        self.databaseManager = [CouchDBManagerOC sharedInstance];
        self.database = [self.databaseManager database];

        [self registerCBLClass];
    }
    
    return self;
}

- (void)registerCBLClass {
    
    CBLModelFactory *factory = self.database.modelFactory;
    [factory registerClass:[TeamModel class] forDocumentType:TeamModel.type];
}

- (NSString *)findTeamIdByTeamDomain:(NSString *)teamDomain {

    NSArray *select = @[@"id"];
    
    NSPredicate *typePredicate = [NSPredicate predicateWithFormat:@"type == 'team'"];
    NSPredicate *tagsPredicate = [NSPredicate predicateWithFormat:@"teamDomain == $TEAMDOMAIN"];
    NSCompoundPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[typePredicate, tagsPredicate]];
    
    NSError *error = nil;
    
    CBLQueryBuilder *tagQueryBuilder = [[CBLQueryBuilder alloc] initWithDatabase: self.database
                                                                          select: select
                                                                  wherePredicate: predicate
                                                                         orderBy: nil
                                                                           error: &error];
    
    NSDictionary *context = @{@"TEAMDOMAIN": teamDomain};
    CBLQueryEnumerator *queryObj  = [tagQueryBuilder runQueryWithContext: context error: &error];
    
    NSString *documentId;
    
    for (CBLQueryRow *row in queryObj) {
        documentId = row.document.properties[@"id"];
    }
    
    return documentId;
}


@end
