//
//  ContactAddress.m
//  Contacts
//
//  Created by Spencer Morris on 1/21/15.
//  Copyright (c) 2015 SolsticeMobile. All rights reserved.
//

#import "ContactAddress.h"

@interface ContactAddress ()

@property (strong, nonatomic) NSDictionary *data;

@end

@implementation ContactAddress

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (self) {
        if ([dictionary isKindOfClass:[NSDictionary class]]) {
            // check object type in case API passes in a null or something unexpected
            self.data = dictionary;
        }
    }
    
    return self;
}

- (NSString *)street
{
    return [self.data objectForKey:@"street"];
}

- (NSString *)city
{
    return [self.data objectForKey:@"city"];
}

- (NSString *)state
{
    return [self.data objectForKey:@"state"];
}

- (NSString *)zip
{
    return [self.data objectForKey:@"zip"];
}

@end

//    "street": "641 W Lake St",
//    "city": "Chicago",
//    "state": "IL",
//    "country": "US",
//    "zip": "60661",
//    "latitude": 41.885383,
//    "longitude": -87.644481