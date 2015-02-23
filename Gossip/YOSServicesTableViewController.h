//
//  YOSServicesTableViewController.h
//  Gossip
//
//  Created by Yosnier on 19/02/15.
//  Copyright (c) 2015 YOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YOSService.h"
#import "YOSCoreDataTableViewController.h"

@interface YOSServicesTableViewController : YOSCoreDataTableViewController

@property (nonatomic,strong) YOSService *services;

-(id) initWithService: (YOSService *) aService;

@end
