//
//  CustomVC.h
//  Contacts
//
//  Created by Spencer Morris on 1/21/15.
//  Copyright (c) 2015 SolsticeMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApiClient.h"
#import "Const.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface CustomVC : UIViewController

@property (strong, nonatomic) ApiClient *apiClient;

@end
