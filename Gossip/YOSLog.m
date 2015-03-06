//
//  YOSLog.m
//  Gossip
//
//  Created by Yosnier on 05/03/15.
//  Copyright (c) 2015 YOS. All rights reserved.
//


#import "YOSService.h"
#import "YOSCredential.h"
#import "YOSEvent.h"
#import "Settings.h"
#import "YOSLog.h"

@implementation YOSLog

-(void) showData {
    
    //Count Services
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[YOSService entityName]];
    req.fetchBatchSize = 20;
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:YOSServiceAttributes.name
                                                          ascending:YES ]];
    NSError *err = nil;
    NSArray *services = [STACK.context executeFetchRequest:req
                                               error:&err];
    NSInteger numServices = [services count];
    
    // Count Credentials
    req = [NSFetchRequest fetchRequestWithEntityName:[YOSCredential entityName]];
    req.fetchBatchSize = 20;
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:YOSCredentialAttributes.name
                                                          ascending:YES ]];
    
    NSArray *credentials = [STACK.context executeFetchRequest:req
                                                  error:&err];
    NSInteger numCredentials = [credentials count];
    
    //Count events
    req = [NSFetchRequest fetchRequestWithEntityName:[YOSEvent entityName]];
    req.fetchBatchSize = 20;
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:YOSEventAttributes.name
                                                          ascending:YES ]];
    
    NSArray *events = [STACK.context executeFetchRequest:req
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
    
    [STACK saveWithErrorBlock:^(NSError *error) {
        NSLog(@"Error when save %s \n\n %@",__func__,error);
    }];
    
}

-(void) autosaving {
    
    NSLog(@"Saving");
    [self save];
    
    [self performSelector:@selector(autosaving)
               withObject:nil
               afterDelay:AUTO_SAVE];
    
}


@end
