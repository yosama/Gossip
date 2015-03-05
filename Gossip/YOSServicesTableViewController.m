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
#import "YOSPhotoContainer.h"
#import "YOSAuthViewController.h"
#import "YOSGoogleOAuth.h"

@interface YOSServicesTableViewController ()

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

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
    
    // configurate cell
    cell.lblNameService.text = service.name;
    cell.lblDescriptionService.text = service.detail;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YOSService *service = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    YOSAuthViewController *authVC = [[YOSAuthViewController alloc] initWithService:service];
    [self.navigationController pushViewController:authVC
                                         animated:YES];
}









@end
