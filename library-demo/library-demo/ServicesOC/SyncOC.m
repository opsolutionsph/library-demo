//
//  SyncOC.m
//  Suites
//
//  Created by OPS on 09/01/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

#import "SyncOC.h"

#import "ServiceConstant.h"
#import "CouchDBManagerOC.h"
#import "KeyChainWrapper.h"

@interface SyncOC()
@property (nonatomic, strong) CBLDatabase *database;
@property (nonatomic, strong) CBLReplication *pushData;
@property (nonatomic, strong) CBLReplication *pullData;
@property (nonatomic, strong) id<CBLAuthenticator> auth;

@property (nonatomic, strong) UIViewController *viewController;
@end

#pragma mark - implementation

@implementation SyncOC

- (id)init {
    
    self = [super init];
    
    if (self) {
        self.database = [[CouchDBManagerOC sharedInstance]database];
        /*NSError* error;
        if (![self.database deleteDatabase: &error]) {
            NSLog(@"database deleted naa!");
        }
        self.database = nil;
        self.database = [[CouchDBManagerOC sharedInstance]database];
        */
        NSURL *url = [NSURL URLWithString:SYNC_RESOURCE];
        self.pushData = [self.database createPushReplication:url];
        self.pullData = [self.database createPullReplication:url];
    }
    
    return self;
}

+ (SyncOC *)sharedInstance {
    static SyncOC *sharedInstance = nil;
    
    if (sharedInstance == nil) {
        
        sharedInstance = [[SyncOC alloc] init];
    }
    
    return sharedInstance;
}

//- (id)initModel:(CBLDatabase *)sharedDatabase {
//    
//    self = [super init];
//    
//    if (self) {
//        self.database = sharedDatabase;
//    }
//    
//    return self;
//}

- (id<CBLAuthenticator>)authenticator {

    NSString *username = [[KeyChainWrapper sharedInstance]getUsername];
    NSString *password = [[KeyChainWrapper sharedInstance]getPassword];

    return [CBLAuthenticator basicAuthenticatorWithName:username password:password];
}

- (void)start:(NSDictionary *)filterParams withPullChannels:(NSArray *)pullChannels withController:(UIViewController *)controller {
    
    self.viewController = controller;

    if ([filterParams count] > 0) {
        [self pushWithFilter:filterParams];
    } else {
        [self push];
    }

    //[self pull:pullChannels];
    [self pull:pullChannels withController:nil];
}

#pragma mark - push

// Sync per module
- (void)pushWithFilter:(NSDictionary *)filterParams {

    if ([filterParams count] > 0) {
        [self.database setFilterNamed: @"byDocType" asBlock: FILTERBLOCK({
            NSString* nameParam = params[@"type"];
            return nameParam && [revision.document[@"type"] isEqualToString: nameParam];
        })];

        self.pushData.filter = @"byDocType";
        self.pushData.filterParams = filterParams; //@{@"type": @"customer", @"type": @"product"};
        // self.pushData.filterParams = @{@"type": @[@"customer", @"product"]};
        [self push];
    }
}

- (void)push {
    self.pushData.continuous = YES;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushDataProgress:) name:kCBLReplicationChangeNotification object:self.pushData];

    self.auth = [self authenticator];
    self.pushData.authenticator = self.auth;

    [self.pushData start];
}

// TODO: Should return (NSFLoat *) data progress
- (void)pushDataProgress:(NSNotification *)notif {
    
    int count = self.pushData.changesCount;
    int completed = self.pushData.completedChangesCount;
    
    if(count > 0) {
        float number = completed / count;
        self.pushProgress = number;
    }
    
    NSLog(@"PUSH Changes: %u", count);
    NSLog(@"PUSH Completed: %u", completed);
    NSLog(@"PUSH Progress: %f", self.pushProgress);
    
    BOOL active = (self.pushData.status == kCBLReplicationActive) || (self.pushData.status == kCBLReplicationActive);
    if (active) {
        NSLog(@"Sync in progress");
    } else {
        NSError *error = self.pushData.lastError;
        if (error.code == 401) {
            NSLog(@"Push Authentication error");
            NSLog(@"PUSH Error: %@", error.localizedDescription);
        }
    }
}

- (void)pull:(NSArray *)withPullChannels withController:(nullable UIViewController *)controller {
    
    // TODO: check first if this is not null
    self.viewController = controller;
    
    self.pullData.continuous = YES;
    self.pullData.channels = withPullChannels;//["customer", "user", "settings"]
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pullDataProgress:) name:kCBLReplicationChangeNotification object:self.pullData];

    self.auth = [self authenticator];
    self.pullData.authenticator = self.auth;
    
    [self.pullData start];
}

- (void)pullDataProgress:(NSNotification *)notif {

    int count = self.pullData.changesCount;
    int completed = self.pullData.completedChangesCount;
    
    if(count > 0) {
        float number = completed / count;
        self.pullProgress = number;
        //self.progressView.progress = (float)count/10.0f;
        CGFloat view = (float)count/10.0f;
    }
    
    BOOL active = (self.pullData.status == kCBLReplicationActive) || (self.pullData.status == kCBLReplicationActive);    
    if (active) {
        NSLog(@"Sync in progress");
    } else {
        NSError *error = self.pullData.lastError;
        if (error.code == 401) {
            NSLog(@"Pull Authentication error");
            NSLog(@"PULL Error: %@", error.localizedDescription);
        }
    }
    
    BOOL idle = (self.pullData.status == kCBLReplicationIdle) || (self.pullData.status == kCBLReplicationIdle);
    if(active == NO) {
        if (idle == YES) {
            NSLog(@"Sync is done.");
        }
    }
}

@end
