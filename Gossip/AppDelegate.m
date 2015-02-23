//
//  AppDelegate.m
//  Gossip
//
//  Created by Yosnier on 17/02/15.
//  Copyright (c) 2015 YOS. All rights reserved.
//

#import "AppDelegate.h"
#import "YOSService.h"
#import "YOSUser.h"
#import "YOSServicesTableViewController.h"
#import "YOSEventsViewController.h"
#import "YOSCoreDataStack.h"

@interface AppDelegate ()
@property (nonatomic, strong) YOSCoreDataStack *stack;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    self.stack = [YOSCoreDataStack coreDataStackWithModelName:@"Model"];
    
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[YOSUser entityName]];
    req.fetchBatchSize = 30;
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:YOSUserAttributes.idUser
                                                          ascending:NO]];
    
    YOSEventsViewController *eventTVC ;
    YOSServicesTableViewController servicesTVC;
    
    if ([[req sortDescriptors] count] > 0 ) {
       eventTVC = [[YOSEventsViewController alloc] init];
    } else {
        
    }

    UITabBarController *tabC = [[UITabBarController alloc] init];
    

    tabC.viewControllers = @[servicesTVC ,eventTVC];
    
    self.window.rootViewController = tabC;
    
    
    
    
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[YOSService entityName]];
    req.fetchBatchSize = 30;
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:YOSServiceAttributes.name
                                                          ascending:YES selector:@selector(caseInsensitiveCompare:)],
                            [NSSortDescriptor sortDescriptorWithKey:YOSServiceAttributes.detail
                                                          ascending:NO]];
    
    NSFetchedResultsController *fc = [[NSFetchedResultsController alloc] initWithFetchRequest:req
                                                                         managedObjectContext:self.stack.context
                                                                           sectionNameKeyPath:nil cacheName:nil];
    
    
    YOSServicesTableViewController *servTVC = [[YOSServicesTableViewController alloc] initWithFetchedResultsController:fc
                                                                                                                 style:UITableViewStylePlain];
    
    
    
    
   
    
     self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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


-(void) createDummyData {
    
    [self.stack zapAllData];
    
    
   [YOSService serviceWithName:@"GitHub"
                        detail:@"The nerd's facebook"
                       context:self.stack.context];
    
    [YOSService serviceWithName:@"Google Drive"
                         detail:@"Data in the cloud 1"
                        context:self.stack.context];
    
    [YOSService serviceWithName:@"Dropbox"
                         detail:@"Data in the cloud 2"
                        context:self.stack.context];
    
}






@end
