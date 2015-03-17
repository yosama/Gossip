//
//  YOSEventssTableViewController.h
//  Gossip
//
//  Created by Yosnier on 23/02/15.
//  Copyright (c) 2015 YOS. All rights reserved.
//

@import UIKit;
#import "YOSEvent.h"
#import "AGTCoreDataTableViewController.h"
#import "YOSServicesTableViewController.h"
#import "YOSGoogleOAuth.h"

@interface YOSEventsTableViewController : AGTCoreDataTableViewController<UISplitViewControllerDelegate,ServicesTableViewControllerDelegate>

@property (nonatomic,strong) YOSEvent *events;


@end
