//
//  ApiClient.m
//  Contacts
//
//  Created by Spencer Morris on 1/21/15.
//  Copyright (c) 2015 SolsticeMobile. All rights reserved.
//

#import "ApiClient.h"
#import "Const.h"

@interface ApiClient ()

@property (strong, nonatomic) AFHTTPRequestOperationManager *manager;

@end

@implementation ApiClient

- (AFHTTPRequestOperationManager *)manager
{
    if (! _manager) {
        _manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:API_BASE_URL];
    }
    
    return _manager;
}

- (void)cancelAllPendingRequests
{
    [self.manager.operationQueue cancelAllOperations];
    self.manager = nil;
}

- (void)getContactsWithCallback:(void (^)(AFHTTPRequestOperation *operation, id responseObject, NSError *error))callback
{
    [self.manager GET:@"contacts.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        callback(operation, responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        callback(operation, nil, error);
    }];
}

- (void)getContactDetailForContactId:(NSString *)contactId withCallback:(void (^)(AFHTTPRequestOperation *operation, id responseObject, NSError *error))callback
{
    NSString *path = [NSString stringWithFormat:@"Contacts/id/%@.json", contactId];
    
    [self.manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        callback(operation, responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        callback(operation, nil, error);
    }];
}

@end
