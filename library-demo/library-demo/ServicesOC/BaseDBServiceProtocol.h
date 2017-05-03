//
//  BaseDBServiceProtocol.h
//  Suites
//
//  Created by OPS on 21/02/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BaseDBServiceProtocol <NSObject>

@required
//- (NSDictionary *)newDocument;

//- (NSDictionary *)saveDocument:(NSDictionary *)data;
- (NSDictionary *)findDocument:(NSString *)id;
- (NSArray *)allDocuments;

@optional
/*
 * @return success: true/false and error code and description
 */
- (NSDictionary *)delistDocument:(NSString *)id;

/*
 * @return success: true/false and error code and description
 */
- (NSDictionary *)deleteDocument:(NSString *)id;

@end
