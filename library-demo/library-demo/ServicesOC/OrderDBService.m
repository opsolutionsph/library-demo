//
//  OrderDBService.m
//  Suites
//
//  Created by OPS on 16/02/2017.
//  Copyright © 2017 OPS. All rights reserved.
//

#import "OrderDBService.h"
#import "OrderModel.h"
#import "OrderDomain.h"

#import "CouchDBManagerOC.h"

#import "ProductDBService.h"

#import "KeyChainWrapper.h"

@interface OrderDBService ()
@property (nonatomic, strong) CouchDBManagerOC *databaseManager;
@property (nonatomic, strong) CBLDatabase *database;
@property (nonatomic, strong) ProductDBService *productDBService;
@property (nonatomic, strong) NSString *username;
@end

@implementation OrderDBService

@synthesize databaseManager;
@synthesize database;
@synthesize productDBService;
@synthesize username;

# pragma Methods

- (id)init {
    
    self = [super init];
    
    if (self) {
        self.databaseManager = [CouchDBManagerOC sharedInstance];
        self.database = [self.databaseManager database];
        self.productDBService = [ProductDBService sharedInstance];
        self.username = [[KeyChainWrapper sharedInstance]getUsername];
        [self registerCBLClass];
    }
    
    return self;
}

- (void)registerCBLClass {
    
    CBLModelFactory *factory = self.database.modelFactory;
    [factory registerClass:[OrderModel class] forDocumentType:OrderModel.type];
}

- (OrderModel *)newDocument {
    
    NSString *documentId = [self.databaseManager generateUUID:OrderModel.type];

    CBLDocument *doc = [self.database documentWithID: documentId];

    OrderModel *model = [OrderModel modelForDocument:doc];
    model.id = documentId;

    return model;
}

- (OrderDomain *)findDocument:(NSString *)documentId {
    
    CBLDocument* document = [self.database documentWithID: documentId];
    
    OrderDomain *data = [[OrderDomain alloc]initData:document.properties];
    
    return data;
    
}

- (NSDictionary *)save:(OrderDomain *)data {

    OrderModel *model;
    
    if (data.id.length == 0) {
        model = [self newDocument];
    }

    // TODO: Complete the properties
    model.type = OrderModel.type;
    model.channels = @[self.username];
    model.customerID = data.customerID;
    model.totalPrice = data.totalPrice;

    NSError *error;
    BOOL isSuccess = [model save:&error];
    NSMutableDictionary *temporaryResult;
    NSDictionary *result;
    
    if(isSuccess) {
        NSLog(@"MODEL saveDocument:: %@", [[model document]properties]);
        temporaryResult[@"isSuccess"] = @YES;
    } else {
        temporaryResult[@"isSuccess"] = @NO;
        // temporaryResult[@"errorCode"] = error.code;
        temporaryResult[@"localizedDescription"] = error.localizedDescription;
    }
    
    result = [NSDictionary dictionaryWithDictionary:temporaryResult];
    
    return result;
}

// list all order documents of the customer 
- (NSArray *)listOrdersForFeedbackByCustomerId:(NSString *)customerID {

    NSString *type = OrderModel.type;
    NSString *viewName = [type stringByAppendingString: @"ordersForFeedback"];
    
    CBLView *view = [self.database viewNamed: viewName];
    
    [view setMapBlock: MAPBLOCK({
        if ([doc[@"type"] isEqual: OrderModel.type] && [doc[@"customerID"] isEqual: customerID]) {
            
            NSMutableDictionary *orderedProducts;
            NSMutableArray *values = [[NSMutableArray alloc]init];
            
            for(NSMutableDictionary *product in doc[@"orderedProducts"]) {
                if ([product[@"productRating"] integerValue] == 0) {
                    
                    orderedProducts = product;

                    NSDictionary *productDetails = [self.productDBService findById: product[@"productID"]];
                    orderedProducts[@"brandName"] = productDetails[@"brandName"];
                    orderedProducts[@"productCode"] = productDetails[@"productCode"];
                    
                    [values addObject: orderedProducts];
                }
            }
            
            if ([orderedProducts count] > 0) {
                emit(doc[@"dateOrdered"], values);
            } else {
                emit(doc[@"dateOrdered"], nil);
            }
        }
    }) version: @"1"];
    
    CBLQuery* query = [[self.database viewNamed: viewName] createQuery];
    query.prefetch = YES;
    query.descending = YES;
    
    NSMutableArray *arrayData = [[NSMutableArray alloc]init];
    
    NSError *error;
    CBLQueryEnumerator *result = [query run: &error];
    
    for (CBLQueryRow* row in result) {
        
        NSDictionary *properties = @{
                             @"dateOrdered" : row.key,
                             @"orderedProducts" : row.value,
                             @"type" : @"",
                             @"id" : @"",
                             @"channels" : @"",
                             @"totalPrice" : @"",
                             @"dateShipped" : @"",
                             @"customerID" : @""
                             };
        NSLog(@"\n\n");
        NSLog(@"properties :: %@", properties);
        NSLog(@"\n\n");
        [arrayData addObject: [[OrderDomain alloc]initData:properties]];
    }
    NSLog(@"\n\n--------------------\n\n");
    NSLog(@"arrayData :: %@", arrayData);
    NSLog(@"\n\n");
    return arrayData;
}

@end
