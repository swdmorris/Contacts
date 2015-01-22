//
//  Contact.h
//  Contacts
//
//  Created by Spencer Morris on 1/21/15.
//  Copyright (c) 2015 SolsticeMobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactPhoneNumbers.h"

@interface Contact : NSObject

- (id)initWithDictionary:(NSDictionary *)dictionary;

- (NSString *)name;
- (NSString *)companyName;
- (NSNumber *)employeeId;
- (NSDate *)birthday;
- (NSString *)phoneNumber;
- (ContactPhoneNumbers *)phoneNumbers;
- (NSURL *)avatarURL;

@end
