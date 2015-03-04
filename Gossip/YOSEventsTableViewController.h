//
//  YOSEventssTableViewController.h
//  Gossip
//
//  Created by Yosnier on 23/02/15.
//  Copyright (c) 2015 YOS. All rights reserved.
//


#define NEW_EVENT_SELECTED_NOTIFICATION @"newEventSelected"
#define KEY_URL @"newEvent"

#import <UIKit/UIKit.h>
#import "YOSEvent.h"
#import "AGTCoreDataTableViewController.h"
#import "YOSAuthViewController.h"

@interface YOSEventsTableViewController : AGTCoreDataTableViewController<AuthViewControllerDelegate,UISplitViewControllerDelegate>

@property (nonatomic,strong) YOSEvent *events;


@end
