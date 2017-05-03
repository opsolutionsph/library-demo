//
//  TeamDBService.h
//  Suites
//
//  Created by OPS on 21/02/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CouchbaseLite/CouchbaseLite.h>

@class TeamModel;
@class TeamDomain;

@interface TeamDBService : NSObject

- (NSString *)findTeamIdByTeamDomain:(NSString *)teamDomain;

@end
