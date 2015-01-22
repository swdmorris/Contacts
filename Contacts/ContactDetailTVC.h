//
//  ContactDetailTVC.h
//  Contacts
//
//  Created by Spencer Morris on 1/21/15.
//  Copyright (c) 2015 SolsticeMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

@interface ContactDetailTVC : UITableViewController <UIAlertViewDelegate>

@property (strong, nonatomic) Contact *contact;

@end
