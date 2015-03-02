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

@interface YOSEventsTableViewController : AGTCoreDataTableViewController

@property (strong,nonatomic) YOSEvent *event;
@property (strong, nonatomic) NSManagedObjectContext *context;


-(id) initWithContext:(NSManagedObjectContext *) aContext;
-(NSFetchedResultsController *) loadEvents;



@end
