//
//  YOSEventssTableViewController.m
//  Gossip
//
//  Created by Yosnier on 23/02/15.
//  Copyright (c) 2015 YOS. All rights reserved.
//

#import "YOSEventsTableViewController.h"
#import "YOSEvent.h"
#import "YOSCredential.h"
#import "YOSService.h"
#import "YOSPhotoContainer.h"
#import "YOSJSONObjectGitHub.h"
#import "YOSEventTableViewCell.h"


@interface YOSEventsTableViewController ()


@end

@implementation YOSEventsTableViewController


#pragma mark - Init

-(id) initWithContext:(NSManagedObjectContext *) aContext {
    
    if (self = [super init]) {
        _context = aContext;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Events";
    
}


-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    YOSEvent *events = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    [self registerNibs];
    
    YOSEventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[YOSEventTableViewCell cellId] ];
    
    cell.lblTypeEvent.text = events.typeEvent;
    cell.lblDescriptionEvent.text = events.name;
    cell.lblUserDate.text = [NSString stringWithFormat:@"Created by %@ date:%@",events.user.name,events.date];
    cell.imvPhotoService.layer.cornerRadius = 25;
    cell.imvPhotoService.image = events.service.photo.image;
    cell.imvPhotoUser.layer.cornerRadius = 25;
    cell.imvPhotoUser.image = events.user.photo.image;
    
    return cell;
}


#pragma mark - Util

// cell Height
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [YOSEventTableViewCell height];
}


//Register the cell in the bundle
- (void) registerNibs {
    
    // Bundle
    NSBundle *main = [NSBundle mainBundle];
    
    // Register custom cell
    UINib *eventNib = [UINib nibWithNibName:@"YOSEventTableViewCell"
                                       bundle:main];
    
    [self.tableView registerNib:eventNib
         forCellReuseIdentifier:[YOSEventTableViewCell cellId]];
    
}


#pragma mark - TableViewDelegate





@end
