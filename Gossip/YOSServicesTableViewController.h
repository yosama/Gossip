//
//  YOSServicesTableViewController.h
//  Gossip
//
//  Created by Yosnier on 19/02/15.
//  Copyright (c) 2015 YOS. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "YOSService.h"
#import "AGTCoreDataTableViewController.h"
#import "YOSAuthViewController.h"

@interface YOSServicesTableViewController : AGTCoreDataTableViewController

@property (nonatomic,strong) YOSService *services;

-(id) initWithService: (YOSService *) aService;

@end
