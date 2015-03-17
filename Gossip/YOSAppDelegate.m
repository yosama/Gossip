//
//  AppDelegate.m
//  Gossip
//
//  Created by Yosnier on 17/02/15.
//  Copyright (c) 2015 YOS. All rights reserved.
//

#import "YOSAppDelegate.h"
#import "YOSService.h"
#import "YOSCredential.h"
#import "YOSServicesTableViewController.h"
#import "YOSEventsTableViewController.h"
#import "AGTCoreDataStack.h"
#import "YOSPhotoContainer.h"
#import "YOSAuthViewController.h"
#import "UIViewController+Navigation.h"
#import "YOSServices.h"
#import "Settings.h"
#import "YOSLog.h"

@interface YOSAppDelegate ()

@end

@implementation YOSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
   
    self.stack = [AGTCoreDataStack coreDataStackWithModelName:@"Model"];
    
    [[YOSServices alloc] init];
    
   // [self customApp];

    [[YOSLog alloc] showData];
    
    YOSServicesTableViewController *servicesTVC = [[YOSServicesTableViewController alloc] initWithFetchedResultsController:[YOSService serviceWithContext:STACK.context]
                                                                                                                     style:UITableViewStylePlain];
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom ] == UIUserInterfaceIdiomPad ) {
        [self configureForIPadAtService:servicesTVC];
    } else {
        [self configureForIPhoneAtService:servicesTVC];
    }
    
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    [[YOSLog alloc] autosaving ];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
   [[YOSLog alloc] autosaving ];
    
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


#pragma mark - Configuration

-(void) configureForIPadAtService: (YOSServicesTableViewController *) aServiceTVC
{
    UISplitViewController* splitVC = [[UISplitViewController alloc] init];
    YOSEventsTableViewController *eventTVC;
    
    
    [aServiceTVC wrapperNavigation];
    
    if ( [self checkExistsuser] == YES ) {
        
        eventTVC = [[YOSEventsTableViewController alloc] initWithFetchedResultsController:[YOSEvent eventWithMOC:STACK.context]
                                                                                    style:UITableViewStylePlain];
        splitVC.viewControllers = @[aServiceTVC, [eventTVC wrapperNavigation]];
        
    } else {
        
        YOSAuthViewController *authVC = [[YOSAuthViewController alloc] initWithService:[YOSService serviceForNameService:@"GitHub"
                                                                                                                 context:STACK.context]];
        
        splitVC.viewControllers = @[[aServiceTVC wrapperNavigation],[authVC wrapperNavigation]];
        
    }
    
    // Assign delegate
    splitVC.delegate = eventTVC;
    aServiceTVC.delegate = eventTVC;
    
    self.window.rootViewController = splitVC;
    
    
}


-(void) configureForIPhoneAtService: (YOSServicesTableViewController *) aServiceTVC
{
    
    if ( [self checkExistsuser] == YES ) {
        
      YOSEventsTableViewController  *eventTVC = [[YOSEventsTableViewController alloc] initWithFetchedResultsController:[YOSEvent eventWithMOC:self.stack.context]
                                                                                    style:UITableViewStylePlain];
        self.window.rootViewController = [eventTVC wrapperNavigation];
    } else {
        self.window.rootViewController =  [aServiceTVC wrapperNavigation];
    }
}


- (BOOL) checkExistsuser
{
    BOOL result;
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[YOSCredential entityName]];
    req.fetchBatchSize = 20;
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:YOSCredentialAttributes.name
                                                          ascending:NO]];
    NSError *error;
    NSInteger numCredentials =[[self.stack.context executeFetchRequest:req
                                                                 error:&error] count];
    
    if (numCredentials > 0 ) {
        result = YES;
    } else {
        result = NO;
    }
    
    return result;
}





@end
