//
//  ServiceConstant.h
//  Suites
//
//  Created by OPS on 09/01/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

//#import <Foundation/Foundation.h>

#define SYNC_PUBLIC_PORT    @"4984"
#define SYNC_PRIVATE_PORT   @"4985"
#define SYNC_DOMAIN         @"http://dev.db.suites.digital" // TODO: Should be https
//
#define SYNC_BUCKET         @"suites"

#define SYNC_RESOURCE       [NSString stringWithFormat:@"%@:%@/%@", SYNC_DOMAIN, SYNC_PUBLIC_PORT, SYNC_BUCKET]
//#define SYNC_RESOURCE       [[SYNC_DOMAIN stringByAppendingString:SYNC_PUBLIC_PORT]

//#define SYNC_RESOURCE       [SYNC_DOMAIN string
