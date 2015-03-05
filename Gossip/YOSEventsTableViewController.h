//
//  YOSEventssTableViewController.h
//  Gossip
//
//  Created by Yosnier on 23/02/15.
//  Copyright (c) 2015 YOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YOSEvent.h"
#import "AGTCoreDataTableViewController.h"
#import "YOSAuthViewController.h"
#import "YOSGoogleOAuth.h"

@interface YOSEventsTableViewController : AGTCoreDataTableViewController<AuthViewControllerDelegate,UISplitViewControllerDelegate,YOSGoogleOAuthDelegate>

@property (nonatomic,strong) YOSEvent *events;


@end
