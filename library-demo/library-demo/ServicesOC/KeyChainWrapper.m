//
//  KeyChainWrapper.m
//  Suites
//
//  Created by OPS on 27/02/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

#import "KeyChainWrapper.h"

@interface KeyChainWrapper ()
@property (nonatomic, strong) NSString *serviceName;
@end

@implementation KeyChainWrapper

static KeyChainWrapper *sharedInstance = nil;

- (id)init {
    
    self = [super init];
    
    if (self) {
        self.serviceName = @"suites.digital";
    }

    return self;
}

+ (KeyChainWrapper *)sharedInstance {
    
    if (sharedInstance == nil) {
        sharedInstance = [[KeyChainWrapper alloc] init];
    }
    
    return sharedInstance;
}

#pragma - Save Keys
- (BOOL)save:(NSString *)username password:(NSString *)password sessionId:(NSString *)sessionId sessionName:(NSString *)sessionName sessionExpirationDate:(NSString *)sessionExpirationDate {

    BOOL isSuccessSaveUsername = [self setUsername:username];
    BOOL isSuccessSavePassword = [self setPassword:password];
    BOOL isSuccessSaveSessionId = [self setSessionId:sessionId];
    BOOL isSuccessSaveSessionName = [self setSessionName:sessionName];
    BOOL isSuccessSaveSessionExpirationDate = [self setSessionExpirationDate:sessionExpirationDate];

    BOOL isSuccess = isSuccessSaveUsername && isSuccessSavePassword && isSuccessSaveSessionId && isSuccessSaveSessionName && isSuccessSaveSessionExpirationDate;

    return isSuccess;
}

- (BOOL)save:(NSString *)username password:(NSString *)password {

    BOOL isSuccessSaveUsername = [self setUsername:username];
    BOOL isSuccessSavePassword = [self setPassword:password];

    return isSuccessSaveUsername && isSuccessSavePassword;
}

#pragma - Set/Get

- (BOOL)setUsername:(NSString *)username {
    NSError *error = nil;
    BOOL isSuccess = [FDKeychain saveItem:username forKey:@"username" forService:self.serviceName error:&error];
    
    return isSuccess;
}

- (NSString *)getUsername {
    NSError *error = nil;
    [self printMe:self.serviceName];
    NSString *data = [FDKeychain itemForKey:@"username" forService:self.serviceName error:&error];

    return data;
}

- (BOOL)setPassword:(NSString *)password {
    NSError *error = nil;
    BOOL isSuccess = [FDKeychain saveItem:password forKey:@"password" forService:self.serviceName error:&error];
    
    return isSuccess;
}

- (NSString *)getPassword {
    NSError *error = nil;
    NSString *data = [FDKeychain itemForKey:@"password" forService:self.serviceName error:&error];

    return data;
}

- (BOOL)setSessionId:(NSString *)sessionId {
    NSError *error = nil;
    BOOL isSuccess = [FDKeychain saveItem:sessionId forKey:@"sessionId" forService:self.serviceName error:&error];
    
    return isSuccess;
}

- (NSString *)getSessionId {
    NSError *error = nil;
    NSString *data = [FDKeychain itemForKey:@"sessionId" forService:self.serviceName error:&error];

    return data;
}

- (BOOL)setSessionName:(NSString *)sessionName {
    NSError *error = nil;
    BOOL isSuccess = [FDKeychain saveItem:sessionName forKey:@"sessionName" forService:self.serviceName error:&error];
    
    return isSuccess;
}

- (NSString *)getSessionName {
    NSError *error = nil;
    NSString *data = [FDKeychain itemForKey:@"sessionName" forService:self.serviceName error:&error];
    
    return data;

}

- (BOOL)setSessionExpirationDate:(NSString *)sessionExpirationDate {
    NSError *error = nil;
    BOOL isSuccess = [FDKeychain saveItem:sessionExpirationDate forKey:@"sessionExpirationDate" forService:self.serviceName error:&error];
    
    return isSuccess;
}

- (NSString *)getSessionExpirationDate {
    NSError *error = nil;
    NSString *data = [FDKeychain itemForKey:@"sessionExpirationDate" forService:self.serviceName error:&error];
    
    return data;
}

#pragma - Remove Keys

- (BOOL)removeUsername {
    NSError *error = nil;
    
    return [FDKeychain deleteItemForKey:@"username" forService:self.serviceName error:&error];
}

- (BOOL)removeUsernameAndPassword {
    NSError *error = nil;
    BOOL isSuccessUsernameDelete = [FDKeychain deleteItemForKey:@"username" forService:self.serviceName error:&error];
    BOOL isSuccessPasswordDelete = [FDKeychain deleteItemForKey:@"password" forService:self.serviceName error:&error];

    return isSuccessUsernameDelete && isSuccessPasswordDelete;
}

- (BOOL)removeAllKeys {
    NSError *error = nil;
    BOOL isSuccessDeleteUsername = [FDKeychain deleteItemForKey:@"username" forService:self.serviceName error:&error];
    BOOL isSuccessDeletePassword = [FDKeychain deleteItemForKey:@"password" forService:self.serviceName error:&error];
    BOOL isSuccessDeleteSessionId = [FDKeychain deleteItemForKey:@"sessionId" forService:self.serviceName error:&error];
    BOOL isSuccessDeleteSessionName = [FDKeychain deleteItemForKey:@"sessionName" forService:self.serviceName error:&error];
    BOOL isSuccessDeleteSessionExpirationDate = [FDKeychain deleteItemForKey:@"sessionExpirationDate" forService:self.serviceName error:&error];

    BOOL isSuccess = isSuccessDeleteUsername && isSuccessDeletePassword && isSuccessDeleteSessionId && isSuccessDeleteSessionName && isSuccessDeleteSessionExpirationDate;

    return isSuccess;
}

// temporary
- (void)printMe:(NSString *)data {
    NSLog(@"\n\n------ key ------");
    NSLog(@"KEY :: %@", data);
    NSLog(@"\n\n");
}
@end
