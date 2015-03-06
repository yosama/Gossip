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

}





- (void) viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.countUsers = [[YOSCredential alloc] countCredentials];
    self.countEvents = [[YOSEvent alloc] countEvents];
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
    //Register cell
    [self registerNibs];
    // create cell
    YOSServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[YOSServiceTableViewCell cellId]];
    
    NSString *cellDescription;
    // configurate cell
    
    if (self.countUsers == 1 ) {
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
