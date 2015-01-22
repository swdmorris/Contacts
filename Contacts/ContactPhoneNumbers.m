//
//  ContactPhoneNumbers.m
//  Contacts
//
//  Created by Spencer Morris on 1/21/15.
//  Copyright (c) 2015 SolsticeMobile. All rights reserved.
//

#import "ContactPhoneNumbers.h"

@interface ContactPhoneNumbers ()

@property (strong, nonatomic) NSDictionary *data;

@end

@implementation ContactPhoneNumbers

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

- (NSString *)mainPhoneNumber
{
    if ([self cellPhoneNumber].length > 0) {
        return [self cellPhoneNumber];
    } else if ([self homePhoneNumber].length > 0) {
        return [self homePhoneNumber];
    } else {
        return [self workPhoneNumber];
    }
}

- (NSString *)cellPhoneNumber
{
    return [self.data objectForKey:@"mobile"];
}

- (NSString *)homePhoneNumber
{
    return [self.data objectForKey:@"home"];
}

- (NSString *)workPhoneNumber
{
    return [self.data objectForKey:@"work"];
}

@end

//    "work": "732-442-0638",
//    "home": "732-442-5218",
//    "mobile": "732-442-5220"

