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

@end
