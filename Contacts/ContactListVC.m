//
//  ContactListVC.m
//  Contacts
//
//  Created by Spencer Morris on 1/21/15.
//  Copyright (c) 2015 SolsticeMobile. All rights reserved.
//

#import "ContactListVC.h"
#import "ContactCell.h"
#import "Contact.h"
#import "ContactDetailTVC.h"

#define kContactCellId @"ContactCell"

@interface ContactListVC ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *contacts;

@end

@implementation ContactListVC
NSString *SEGUE_CONTACT_DETAIL = @"contactDetail";

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self performLoadContacts];
}

#pragma mark- UITableView datasource/delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // no use for separate sections unless you wanted to separate
    // contacts by first letter of last name or something like that
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:kContactCellId];
    
    Contact *contact = [self.contacts objectAtIndex:indexPath.row];
    [cell setContactName:contact.name phoneNumber:contact.phoneNumber andAvatarImageURL:contact.avatarURL];
    
    return cell;
}

#pragma mark- Actions

- (IBAction)refreshContactsButtonPressed
{
    [self performLoadContacts];
}

#pragma mark- Networking

- (void)performLoadContacts
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [self.apiClient getContactsWithCallback:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (! error && operation.response.statusCode == 200 && [responseObject isKindOfClass:[NSArray class]]) {
            NSLog(@"Recieved contacts");
            NSMutableArray *mutableContacts = [[NSMutableArray alloc] init];
            for (NSDictionary *contactDictonary in responseObject) {
                Contact *contact = [[Contact alloc] initWithDictionary:contactDictonary];
                [mutableContacts addObject:contact];
            }
            self.contacts = [mutableContacts copy];
            [self.tableView reloadData];
        } else {
            NSLog(@"Error getting contacts");
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"There was an error loading contacts. Please check your connection and try again." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil] show];
        }
    }];
}

#pragma mark- End of lifecycle

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:SEGUE_CONTACT_DETAIL]) {
        ContactDetailTVC *detailTVC = (ContactDetailTVC *) [segue destinationViewController];
        NSIndexPath *indexPathOfSelectedCell = [self.tableView indexPathForSelectedRow];
        Contact *selectedContact = [self.contacts objectAtIndex:indexPathOfSelectedCell.row];
        [detailTVC setContact:selectedContact];
    }
}

@end
