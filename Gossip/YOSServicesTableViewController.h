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

@class YOSServicesTableViewController;

@protocol ServicesTableViewControllerDelegate <NSObject>

-(void) servicesViewController: (YOSServicesTableViewController *) sender fetchResultController: (NSFetchedResultsController *) aFrc;
-(void) servicesViewController: (YOSServicesTableViewController *) sender service: (YOSService *) aService;

@end

@interface YOSServicesTableViewController : AGTCoreDataTableViewController

@property (nonatomic,strong) YOSService *services;

@property (weak) id<ServicesTableViewControllerDelegate> delegate;

-(id) initWithService: (YOSService *) aService;

@end
