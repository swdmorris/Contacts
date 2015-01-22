//
//  Contact.m
//  Contacts
//
//  Created by Spencer Morris on 1/21/15.
//  Copyright (c) 2015 SolsticeMobile. All rights reserved.
//

#import "Contact.h"

@interface Contact ()

@property (strong, nonatomic) NSDictionary *data;

@end

@implementation Contact

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

- (NSString *)name
{
    return [self.data objectForKey:@"name"];
}

- (NSString *)companyName
{
    return [self.data objectForKey:@"company"];
}

- (NSNumber *)employeeId
{
    return [self.data objectForKey:@"employeeId"];
}

- (NSDate *)birthday
{
    NSNumber *timeIntervalNumber = [self.data objectForKey:@"birthdate"];
    NSInteger timeInterval = timeIntervalNumber.integerValue;
    
    return [NSDate dateWithTimeIntervalSince1970:timeInterval];
}

- (NSString *)phoneNumber
{
    return [[self phoneNumbers] mainPhoneNumber];
}

- (ContactPhoneNumbers *)phoneNumbers
{
    return [[ContactPhoneNumbers alloc] initWithDictionary:[self.data objectForKey:@"phone"]];
}

- (NSURL *)avatarURL
{
    NSString *avatarUrlString = [self.data objectForKey:@"smallImageURL"];
    if ([avatarUrlString isKindOfClass:[NSString class]] && avatarUrlString.length > 0) {
        // check that url is a non-empty string because an invalid url will cause
        // the URLWithString method to crash the app
        return [NSURL URLWithString:avatarUrlString];
    } else {
        return nil;
    }
}

//"name": "Zackary Mockus",
//"employeeId":4,
//"company": "Metropolitan Elevator Co",
//"detailsURL":"https://solstice.applauncher.com/external/Contacts/id/4.json",
//"smallImageURL": "https://solstice.applauncher.com/external/Contacts/images/image14_small.jpeg",
//"birthdate": "1325412813",
//"phone": {
//    "work": "732-442-0638",
//    "home": "732-442-5218",
//    "mobile": "732-442-5220"
//}

@end
