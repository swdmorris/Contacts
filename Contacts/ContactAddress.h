//
//  ContactAddress.h
//  Contacts
//
//  Created by Spencer Morris on 1/21/15.
//  Copyright (c) 2015 SolsticeMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactAddress : NSObject

- (id)initWithDictionary:(NSDictionary *)dictionary;

- (NSString *)street;
- (NSString *)city;
- (NSString *)state;
- (NSString *)zip;

@end
