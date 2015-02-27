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

@interface YOSServicesTableViewController ()

@end

@implementation YOSServicesTableViewController


-(id) initWithService: (YOSService *) aService {
    
    if (self = [super initWithNibName:nil
                               bundle:nil] ) {
        _services = aService;
    }
    
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Services";
    
    
}

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Capture the services
    YOSService *service = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    [self registerNibs];
    
    // create cell
    YOSServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[YOSServiceTableViewCell cellId]];
    
    
    // configurate cell
    cell.lblNameService.text = service.name;
    cell.lblDescriptionService.text = service.detail;
    cell.imvPhotoService.image = service.photo.image;
    
    
    return cell;
    
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



// cell Height
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [YOSServiceTableViewCell height];
    
}


//Register the cells in the bundle
- (void) registerNibs {
    
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
