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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Events";
    
}


-(void) viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YOSEvent *events = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    [self registerNibs];
    
    YOSEventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[YOSEventTableViewCell cellId] ];
    
      
    cell.lblTypeEvent.text = events.typeEvent;
    cell.lblDescriptionEvent.text = events.name;
    
    NSInteger dayDiferences = [self daysBetweenDate:events.date
                                            andDate:[NSDate date]];
    NSDateFormatter *df = [NSDateFormatter new];
    NSString *time;
    
    if (dayDiferences > 1) {
        df.dateFormat = @"dd-MM-yyyy";
        time = [df stringFromDate:events.date];
        
    } else {
        NSDateFormatter *df = [NSDateFormatter new];
        df.dateFormat = @"HH:mm:ss";
        time = [df stringFromDate:events.date];
    }
    
    cell.lblUserDate.text = [NSString stringWithFormat:@"created by %@ %@",events.user.name,time];
    cell.imvPhotoService.image = events.service.photo.image;
    cell.imvPhotoUser.image = events.user.photo.image;
    
    return cell;
}


#pragma mark - Util

// cell Height
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    return [YOSEventTableViewCell height];
}


//Register the cell in the bundle
- (void) registerNibs
{
    
    // Bundle
    NSBundle *main = [NSBundle mainBundle];
    
    // Register custom cell
    UINib *eventNib = [UINib nibWithNibName:@"YOSEventTableViewCell"
                                       bundle:main];
    
    [self.tableView registerNib:eventNib
         forCellReuseIdentifier:[YOSEventTableViewCell cellId]];
    
}



- (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSCalendarUnitDay
                startDate:&fromDate
                 interval:NULL
                  forDate:fromDateTime];
    
    [calendar rangeOfUnit:NSCalendarUnitDay
                startDate:&toDate
                 interval:NULL
                  forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSCalendarUnitDay
                                               fromDate:fromDate
                                                 toDate:toDate
                                                options:0];
    
    return [difference day];
}



#pragma mark - TableViewDelegate





@end
