//
//  ContactDetailTVC.m
//  Contacts
//
//  Created by Spencer Morris on 1/21/15.
//  Copyright (c) 2015 SolsticeMobile. All rights reserved.
//

#import "ContactDetailTVC.h"
#import "ApiClient.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "Contact.h"
#import "ContactDetail.h"

@interface ContactDetailTVC ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *workNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@property (strong, nonatomic) ContactDetail *contactDetails;
@property (strong, nonatomic) ApiClient *apiClient;

@end

@implementation ContactDetailTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self performLoadContactDetails];
}

- (ApiClient *)apiClient
{
    // create API Client when needed
    if (! _apiClient) {
        _apiClient = [[ApiClient alloc] init];
    }
    
    return _apiClient;
}

- (void)setupUI
{
    self.nameLabel.text = self.contact.name;
    self.companyNameLabel.text = self.contact.companyName;
    self.cellNumberLabel.text = self.contact.phoneNumbers.cellPhoneNumber;
    self.homeNumberLabel.text = self.contact.phoneNumbers.homePhoneNumber;
    self.workNumberLabel.text = self.contact.phoneNumbers.workPhoneNumber;
    self.addressLabel.text = self.contactDetails.addressFormatted;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMMM d, yyyy"];
    self.birthdayLabel.text = [dateFormatter stringFromDate:self.contact.birthday];
    
    self.emailLabel.text = self.contactDetails.email;
    [self.avatarImageView sd_setImageWithURL:self.contactDetails.avatarURL];
}

#pragma mark- Networking

- (void)performLoadContactDetails
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [self.apiClient getContactDetailForContactId:self.contact.employeeId.stringValue withCallback:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (! error && operation.response.statusCode == 200 && [responseObject isKindOfClass:[NSDictionary class]]) {
            NSLog(@"Contact details loaded");
            self.contactDetails = [[ContactDetail alloc] initWithDictionary:responseObject];
            [self setupUI];
        } else {
            NSLog(@"Error getting contact details");
        }
    }];
}

#pragma mark- End of lifecycle

- (void)dealloc
{
    // make sure that API client doesn't try to access view controller after
    // it has been deallocated from memory
    [self.apiClient cancelAllPendingRequests];
    self.apiClient = nil;
}

@end
