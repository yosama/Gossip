//
//  YOSGitHubAuthViewController.h
//  Gossip
//
//  Created by Yosnier on 25/02/15.
//  Copyright (c) 2015 YOS. All rights reserved.
//



@import UIKit;
#import "YOSService.h"
@class YOSAuthViewController;

@interface YOSAuthViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, strong) YOSService *service;
@property (weak, nonatomic) IBOutlet UIImageView *imvLogoService;
@property (weak, nonatomic) IBOutlet UITextField *txfUser;


-(id) initWithService: (YOSService *) aService;
-(IBAction)btnSingin:(id)sender;
-(IBAction)removeKeyBoard:(id)sender;

@end
