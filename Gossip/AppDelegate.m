//
//  AppDelegate.m
//  Gossip
//
//  Created by Yosnier on 17/02/15.
//  Copyright (c) 2015 YOS. All rights reserved.
//

#import "AppDelegate.h"
#import "YOSService.h"
#import "YOSCredential.h"
#import "YOSServicesTableViewController.h"
#import "YOSEventsTableViewController.h"
#import "AGTCoreDataStack.h"
#import "YOSPhotoContainer.h"
#import "YOSAuthViewController.h"
#import "UIViewController+Navigation.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    self.stack = [AGTCoreDataStack coreDataStackWithModelName:@"Model"];
    
    [self createDummyData];
    
    [self showData];
    
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[YOSCredential entityName]];
    req.fetchBatchSize = 20;
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:YOSCredentialAttributes.name
                                                          ascending:NO]];
    NSError *error;
    NSInteger numCredentials =[[self.stack.context executeFetchRequest:req
                                                                 error:&error] count];
    YOSEventsTableViewController *eventTVC = nil;
    YOSServicesTableViewController *servicesTVC = nil;
    
    if ( numCredentials > 0 ) {
        
        eventTVC = [[YOSEventsTableViewController alloc] initWithFetchedResultsController:[YOSEvent eventWithMOC:self.stack.context] style:UITableViewStylePlain];
        
        self.window.rootViewController = [eventTVC wrapperNavigation];
        
    } else {

        servicesTVC = [[YOSServicesTableViewController alloc] initWithFetchedResultsController:[YOSService serviceWithContext:self.stack.context]
                                                                                                                style:UITableViewStylePlain];
        self.window.rootViewController = [servicesTVC wrapperNavigation];
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    [self save];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [self save];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



#pragma mark - Util

-(void) createDummyData {
    
    // [self.stack zapAllData];
    
    YOSPhotoContainer  *photoGit = [YOSPhotoContainer  insertInManagedObjectContext:self.stack.context];
    photoGit.image = [UIImage imageNamed:@"octocat.png"];
    [YOSService serviceWithName:@"GitHub"
                         detail:@"the nerd's facebook"
                          photo: photoGit
                        context:self.stack.context];
    
    YOSPhotoContainer  *photoGoogle = [YOSPhotoContainer  insertInManagedObjectContext:self.stack.context];
    photoGoogle.image = [UIImage imageNamed:@"googleDrive.png"];
    [YOSService serviceWithName:@"Google Drive"
                         detail:@"Data store in the cloud 1"
                          photo:photoGoogle
                        context:self.stack.context];
    
    YOSPhotoContainer  *photoDropbox = [YOSPhotoContainer  insertInManagedObjectContext:self.stack.context];
    photoDropbox.image = [UIImage imageNamed:@"dropbox.png"];
    [YOSService serviceWithName:@"Dropbox"
                         detail:@"Data store in the cloud 2"
                          photo: photoDropbox
                        context:self.stack.context];
}



-(void) showData {
    
    //Count Services
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[YOSService entityName]];
    req.fetchBatchSize = 20;
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:YOSServiceAttributes.name
                                                          ascending:YES ]];
    NSError *err = nil;
    NSArray *services = [self.stack.context executeFetchRequest:req
                                                          error:&err];
    NSInteger numServices = [services count];
    
    // Count Credentials
    req = [NSFetchRequest fetchRequestWithEntityName:[YOSCredential entityName]];
    req.fetchBatchSize = 20;
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:YOSCredentialAttributes.name
                                                          ascending:YES ]];
    
    NSArray *credentials = [self.stack.context executeFetchRequest:req
                                                             error:&err];
    NSInteger numCredentials = [credentials count];
    
    //Count events
    req = [NSFetchRequest fetchRequestWithEntityName:[YOSEvent entityName]];
    req.fetchBatchSize = 20;
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:YOSEventAttributes.name
                                                          ascending:YES ]];
    
    NSArray *events = [self.stack.context executeFetchRequest:req
                                                        error:&err];
    NSInteger numEvents = [events count];
    
    printf("=========================================\n");
    printf("Number of services:        %lu\n", (unsigned long)numServices);
    printf("Number of credentials:        %lu\n", (unsigned long)numCredentials);
    printf("Number of events:            %lu\n", (unsigned long)numEvents);
    printf("========================================\n\n\n");
    
    // NSLog(@"Services: %@",[services description]);
    //yNSLog(@"Services: %@",[events description]);
    [self performSelector:@selector(showData)
               withObject:nil
               afterDelay:5];
    
}


-(void) save {
    
    [self.stack saveWithErrorBlock:^(NSError *error) {
        NSLog(@"Error when save %s \n\n %@",__func__,error);
    }];
    
}

-(void) autosaving {
    
    NSLog(@"Saving");
    [self save];
    
    [self performSelector:@selector(autosaving)
               withObject:nil
               afterDelay:10];
    
}



@end
