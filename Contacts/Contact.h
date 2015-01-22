//
//  Contact.h
//  Contacts
//
//  Created by Spencer Morris on 1/21/15.
//  Copyright (c) 2015 SolsticeMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject

- (id)initWithDictionary:(NSDictionary *)dictionary;

- (NSString *)name;
- (NSNumber *)employeeId;
- (NSString *)phoneNumber;
- (NSURL *)avatarURL;

@end
