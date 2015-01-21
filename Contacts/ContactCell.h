//
//  ContactCell.h
//  Contacts
//
//  Created by Spencer Morris on 1/21/15.
//  Copyright (c) 2015 SolsticeMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactCell : UITableViewCell

- (void)setContactName:(NSString *)name phoneNumber:(NSString *)phoneNumber andAvatarImageURL:(NSURL *)avatarURL;

@end
