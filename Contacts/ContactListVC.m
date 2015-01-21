//
//  ContactListVC.m
//  Contacts
//
//  Created by Spencer Morris on 1/21/15.
//  Copyright (c) 2015 SolsticeMobile. All rights reserved.
//

#import "ContactListVC.h"

@interface ContactListVC ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *contacts;

@end

@implementation ContactListVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    return nil;
}

@end
