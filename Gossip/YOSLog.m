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
    
    printf("=========================================\n");
    printf("Number of services:        %lu\n", (unsigned long)[[YOSService alloc] countServices]);
    printf("Number of credentials:        %lu\n", (unsigned long)[[YOSCredential alloc] countCredentials]);
    printf("Number of events:            %lu\n", (unsigned long)[[YOSEvent alloc] countEvents]);
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

    if (AUTO_SAVE){
        NSLog(@"Saving");
        [self save];
        
        [self performSelector:@selector(autosaving)
                   withObject:nil
                   afterDelay:AUTO_SAVE_DELAY];
    }
    
    
  
    
}


@end
