//
//  ApiClient.h
//  Contacts
//
//  Created by Spencer Morris on 1/21/15.
//  Copyright (c) 2015 SolsticeMobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface ApiClient : NSObject

- (void)cancelAllPendingRequests;

- (void)getContactsWithCallback:(void (^)(AFHTTPRequestOperation *operation, id responseObject, NSError *error))callback;
- (void)getContactDetailForContactId:(NSString *)contactId withCallback:(void (^)(AFHTTPRequestOperation *operation, id responseObject, NSError *error))callback;

@end
