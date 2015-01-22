//
//  ContactCell.m
//  Contacts
//
//  Created by Spencer Morris on 1/21/15.
//  Copyright (c) 2015 SolsticeMobile. All rights reserved.
//

#import "ContactCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ContactCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;

@end

@implementation ContactCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.avatarImageView.layer.cornerRadius = MIN((self.avatarImageView.frame.size.width / 2.0), (self.avatarImageView.frame.size.height / 2.0));
}

- (void)setContactName:(NSString *)name phoneNumber:(NSString *)phoneNumber andAvatarImageURL:(NSURL *)avatarURL
{
    [self.avatarImageView sd_setImageWithURL:avatarURL placeholderImage:[UIImage imageNamed:@"icon_avatar.jpg"]];
    self.nameLabel.text = name;
    self.phoneNumberLabel.text = phoneNumber;
}

@end
