//
//  SyncOC.h
//  Suites
//
//  Created by OPS on 09/01/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CouchbaseLite/CouchbaseLite.h"

@interface SyncOC : NSObject

@property (nonatomic) float pushProgress;
@property (nonatomic) float pullProgress;

+(SyncOC *) sharedInstance;


//- (void)start:(NSArray *)withPullChannels;

- (void)start:(NSDictionary *)filterParams withPullChannels:(NSArray *)pullChannels withController:(UIViewController *)controller;

- (void)push;
- (void)pushWithFilter:(NSDictionary *)filterParams;
- (void)pushDataProgress:(NSNotification *)notification; // TODO: Should return (NSFLoat *) data progress

- (void)pull:(NSArray *)withPullChannels withController:(UIViewController *)controller;
- (void)pullDataProgress:(NSNotification *)notification; // TODO: Should return (NSFLoat *) data progress

@end
