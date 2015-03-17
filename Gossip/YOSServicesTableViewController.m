//
//  YOSServicesTableViewController.m
//  Gossip
//
//  Created by Yosnier on 19/02/15.
//  Copyright (c) 2015 YOS. All rights reserved.
//

#import "YOSServicesTableViewController.h"
#import "YOSServiceTableViewCell.h"
#import "YOSService.h"
#import "YOSCredential.h"
#import "YOSEvent.h"
#import "YOSPhotoContainer.h"
#import "YOSAuthViewController.h"
#import "YOSGoogleOAuth.h"
#import "YOSEventsTableViewController.h"
#import "Settings.h"

@interface YOSServicesTableViewController ()

@property (nonatomic) NSInteger countUsers;
@property (nonatomic) NSInteger countEvents;

@end

@implementation YOSServicesTableViewController

#pragma mark - Init

-(id) initWithService: (YOSService *) aService
{
    if (self = [super initWithNibName:nil
                               bundle:nil] ) {
        _services = aService;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Services";
    //Register cell
    [self registerNibs];

    [[UITableView appearance] setBackgroundColor:[UIColor colorWithHue:0
                                                            saturation:0
                                                            brightness:93
                                                                 alpha:1 ]];
    
   
    
}





- (void) viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.countUsers = [[YOSCredential alloc] countCredentials];
    self.countEvents = [[YOSEvent alloc] countEvents];

    if (self.countUsers > 0 ) {
        
        UIBarButtonItem *btnBarItem = [[UIBarButtonItem alloc] initWithTitle:@"Tracks"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(goTracks)];
        self.navigationItem.rightBarButtonItem = btnBarItem;
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Capture the services
    YOSService *service = [self.fetchedResultsController objectAtIndexPath:indexPath];
   
    // create cell
    YOSServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[YOSServiceTableViewCell cellId]];
    
    NSString *cellDescription;
    // configurate cell
    
    if (self.countUsers > 0 || self.countUsers == 1 ) {
        cellDescription = [NSString stringWithFormat:@" User:%lu  Events:%lu",(unsigned long)self.countUsers,(unsigned long)self.countEvents];
    } else if (self.countUsers > 1 ) {
        cellDescription = [NSString stringWithFormat:@" Users:%lu Events: %lu",(unsigned long)self.countUsers,(unsigned long)self.countEvents];
    } else {
        cellDescription = service.detail;
    }
    
    cell.lblNameService.text = service.name;
    cell.lblDescriptionService.text = cellDescription;
    cell.imvPhotoService.image = service.photo.image;
    
    return cell;
    
}


#pragma mark - Utils

// cell Height
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [YOSServiceTableViewCell height];
    
}

//Register the cells in the bundle
- (void) registerNibs
{
    // Bundle
    NSBundle *main = [NSBundle mainBundle];
    
    // Register custom name  cell
    UINib *serviceNib = [UINib nibWithNibName:@"YOSServiceTableViewCell"
                                       bundle:main];
    
    [self.tableView registerNib:serviceNib
         forCellReuseIdentifier:[YOSServiceTableViewCell cellId]];
    
}

-(void) goTracks
{
    
    
    
    [self.navigationController pushViewController:[[YOSEventsTableViewController alloc] initWithFetchedResultsController:[YOSEvent eventWithMOC:STACK.context]
                                                                                                                   style:UITableViewStylePlain]
                                         animated:YES];
    
}


#pragma mark - TableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    YOSService *service = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    YOSAuthViewController *authVC = [[YOSAuthViewController alloc] initWithService:service];
    [self.navigationController pushViewController:authVC
                                         animated:YES];
}



#pragma mark - ServicesTableViewDelegate

-(void) authViewController: (YOSServicesTableViewController *) sender fetchResultController: (NSFetchedResultsController *) aFrc
{
    
}









@end
