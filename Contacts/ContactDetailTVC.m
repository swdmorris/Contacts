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

#define INDEXPATH_CELL_PHONE [NSIndexPath indexPathForRow:1 inSection:0]
#define INDEXPATH_HOME_PHONE [NSIndexPath indexPathForRow:2 inSection:0]
#define INDEXPATH_WORK_PHONE [NSIndexPath indexPathForRow:3 inSection:0]

typedef enum {
    callPhoneNumberAlertType,
    noAlertType
} AlertType;

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
@property AlertType alertType;

@end

@implementation ContactDetailTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self performLoadContactDetails];
    self.title = self.contact.name;
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
    self.avatarImageView.layer.cornerRadius = MIN((self.avatarImageView.frame.size.width / 2.0), (self.avatarImageView.frame.size.height / 2.0));
}

#pragma mark- UITableView datasource/delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // hide cells for phone numbers if no phone number is present
    if ([indexPath isEqual:INDEXPATH_CELL_PHONE] && self.contact.phoneNumbers.cellPhoneNumber.length < 1) {
        return 0.0f;
    } else if ([indexPath isEqual:INDEXPATH_HOME_PHONE] && self.contact.phoneNumbers.homePhoneNumber.length < 1) {
        return 0.0f;
    } else if ([indexPath isEqual:INDEXPATH_WORK_PHONE] && self.contact.phoneNumbers.workPhoneNumber.length < 1) {
        return 0.0f;
    } else {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    if ([indexPath isEqual:INDEXPATH_CELL_PHONE]) {
        self.alertType = callPhoneNumberAlertType;
        NSString *title = [NSString stringWithFormat:@""];
        NSString *message = [NSString stringWithFormat:@""];
        [[[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil] show];
    } else if ([indexPath isEqual:INDEXPATH_HOME_PHONE]) {
        self.alertType = callPhoneNumberAlertType;
    } else if ([indexPath isEqual:INDEXPATH_WORK_PHONE]) {
        self.alertType = callPhoneNumberAlertType;
    }
}

#pragma mark- UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
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
