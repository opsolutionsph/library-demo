//
//  KeyChainWrapper.h
//  Suites
//
//  Created by OPS on 27/02/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyChainWrapper : NSObject

+(KeyChainWrapper *)sharedInstance;

#pragma save keys
- (BOOL)save:(NSString *)username password:(NSString *)password sessionId:(NSString *)sessionId sessionName:(NSString *)sessionName sessionExpirationDate:(NSString *)sessionExpirationDate;

- (bool)save:(NSString *)username password:(NSString *)password;

#pragma get
- (NSString *)getUsername;
- (NSString *)getPassword;
- (NSString *)getSessionId;
- (NSString *)getSessionName;
- (NSString *)getSessionExpirationDate;

#pragma remove keys

- (bool)removeUsername;
- (bool)removeUsernameAndPassword;
- (bool)removeAllKeys;

@end
