//
//  ContactDetail.m
//  Contacts
//
//  Created by Spencer Morris on 1/21/15.
//  Copyright (c) 2015 SolsticeMobile. All rights reserved.
//

#import "ContactDetail.h"
#import "ContactAddress.h"

@interface ContactDetail ()

@property (strong, nonatomic) NSDictionary *data;

@end

@implementation ContactDetail

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

- (NSString *)email
{
    return [self.data objectForKey:@"email"];
}

- (ContactAddress *)address
{
    return [[ContactAddress alloc] initWithDictionary:[self.data objectForKey:@"address"]];
}

- (NSString *)addressFormatted
{
    ContactAddress *address = [self address];
    
    return [NSString stringWithFormat:@"%@\n%@, %@ %@", address.street, address.city, address.state, address.zip];
}

- (BOOL)isFavorite
{
    NSNumber *isFavoriteNumber = [self.data objectForKey:@"favorite"];
    if ([isFavoriteNumber isKindOfClass:[NSNumber class]] && isFavoriteNumber.boolValue) {
        return YES;
    } else {
        return NO;
    }
}

- (NSURL *)avatarURL
{
    NSString *avatarUrlString = [self.data objectForKey:@"largeImageURL"];
    if ([avatarUrlString isKindOfClass:[NSString class]] && avatarUrlString.length > 0) {
        // check that url is a non-empty string because an invalid url will cause
        // the URLWithString method to crash the app
        return [NSURL URLWithString:avatarUrlString];
    } else {
        return nil;
    }
}

//"employeeId":5,
//"favorite": false,
//"largeImageURL": "https://solstice.applauncher.com/external/Contacts/images/image3_large.jpeg",
//"email": "rosemarie@fifield.com",
//"website": "http://www.solstice-mobile.com",
//"address": {
//    "street": "641 W Lake St",
//    "city": "Chicago",
//    "state": "IL",
//    "country": "US",
//    "zip": "60661",
//    "latitude": 41.885383,
//    "longitude": -87.644481
//}

@end
