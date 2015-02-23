//
//  YOSEventsViewController.h
//  Gossip
//
//  Created by Yosnier on 23/02/15.
//  Copyright (c) 2015 YOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YOSGoogleAuth.h"

@interface YOSEventsViewController : UIViewController<UITableViewDelegate,YOSGoogleAuthDelegate>

@property (nonatomic,strong) NSMutableArray *events;


- (IBAction)btnGrantAuthorization:(id)sender;

- (IBAction)btnRevokeAuthorization:(id)sender;


@end
