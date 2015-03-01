//
//  YOSJSONObjectGitHub.m
//  Gossip
//
//  Created by Yosnier on 25/02/15.
//  Copyright (c) 2015 YOS. All rights reserved.
//

#import "YOSJSONObjectGitHub.h"
#import "YOSEvent.h"
#import "YOSService.h"
#import "YOSCredential.h"
#import "YOSPhotoContainer.h"



@interface YOSJSONObjectGitHub ()
@property (nonatomic, strong) YOSService *service;

@end

@implementation YOSJSONObjectGitHub


#pragma mark - Init

-(id) initWithService: (YOSService *) aService user:(NSString *) anUser  {
    
    if (self = [super init]) {
        _service = aService;
        AppDelegate *appDel= [[UIApplication sharedApplication] delegate];
        
        [self downloadJSONUserData:anUser context:appDel.stack.context];
        [self downloadJSONUserEvents:anUser context:appDel.stack.context];
        
        
    }
    return  self;
}



-(void) showData {
    
    NSLog(@"Datos usuario: %@ ",[self.model objectForKey:@"actor:"]);
    
}


#pragma mark - Util


// Get the user data
-(void) downloadJSONUserData: (NSString *) anUser context:(NSManagedObjectContext *) aContext {
    
    NSString *userUrl = [NSString stringWithFormat:@"https://api.github.com/users/%@",anUser];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:userUrl]];
    NSURLResponse *response = [[NSURLResponse alloc] init];
    NSError *err;
    
    NSData *userData = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:&response
                                                         error:&err];
    if (userData) {
        
        NSDictionary *JSONSUserData = [NSJSONSerialization JSONObjectWithData:userData
                                                                      options:kNilOptions
                                                                        error:&err];
        if (JSONSUserData) {
            
            YOSCredential *credential = [YOSCredential credentialWithDictionary:JSONSUserData
                                                                        context:aContext];
        } else {
            NSLog(@"Error al parsear el JSON Datos de usuario :%@ ", err.localizedDescription);
        }
        
    } else {
        NSLog(@"Error al cargar los datos del servidor:%@ ", err.localizedDescription);
    }
    
}


-(void) downloadJSONUserEvents:(NSString *) anUser context: (NSManagedObjectContext *) aContext {
    
    // Get the user
    NSString *eventsUrl = [NSString stringWithFormat:@"https://api.github.com/users/%@/events",anUser];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:eventsUrl]];
    NSURLResponse *response = [[NSURLResponse alloc] init];
    NSError *err;
    
    NSData *eventsData = [NSURLConnection sendSynchronousRequest:request
                                               returningResponse:&response
                                                           error:&err];
    if (eventsData) {
        
        NSArray *JSONSEventsData = [NSJSONSerialization JSONObjectWithData:eventsData
                                                                   options:kNilOptions
                                                                     error:&err];
        if (JSONSEventsData) {
            
            for (NSDictionary *dict in JSONSEventsData) {
                
                YOSEvent *events = [YOSEvent eventWithDictionary:dict
                                                         service:self.service
                                                         context:aContext];
            }
            
        } else {
            NSLog(@"Error al parsear el JSON Eventos de usuarios :%@ ", err.localizedDescription);
        }
        
    } else {
        NSLog(@"Error al cargar los datos del servidor:%@ ", err.localizedDescription);
    }
    
    
}







@end
