//
//  SettingsDBService.h
//  Suites
//
//  Created by OPS on 11/01/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CouchbaseLite/CouchbaseLite.h>

@class SettingsModelOC;
@class SettingsDomainOC;

@interface SettingsDBService : NSObject

+(SettingsDBService *) sharedInstance;

- (SettingsModelOC *)createInstance;
- (NSString *)update:(SettingsModelOC*)data;
- (NSMutableArray *)findAll;
- (NSDictionary *)findById:(NSString *)id;

@end
