//
//  ApiClient.m
//  Contacts
//
//  Created by Spencer Morris on 1/21/15.
//  Copyright (c) 2015 SolsticeMobile. All rights reserved.
//

#import "ApiClient.h"
#import "Const.h"
#import <AFNetworking/AFNetworking.h>

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

@end
