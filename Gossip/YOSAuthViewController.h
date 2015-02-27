//
//  YOSGitHubAuthViewController.h
//  Gossip
//
//  Created by Yosnier on 25/02/15.
//  Copyright (c) 2015 YOS. All rights reserved.
//

#define GITHUB @"GitHub"
#define DROPBOX @"Dropbox"
#define GOOGLE @"Google Drive"

@import UIKit;
#import "YOSService.h"


@interface YOSAuthViewController : UIViewController<UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) YOSService *service;
@property (weak, nonatomic) IBOutlet UIImageView *imvLogoService;
@property (weak, nonatomic) IBOutlet UITextField *txfUser;

@property (weak, nonatomic) IBOutlet UITextField *txfPassword;

-(id) initWithService: (YOSService *) aService;

- (IBAction)btnSingin:(id)sender;
-(IBAction)removeKeyBoard:(id)sender;

@end
