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
@property (nonatomic, strong) AppDelegate *appDelegate;
@property (nonatomic) BOOL valid;


@end

@implementation YOSJSONObjectGitHub

#pragma mark - Class methods

+(instancetype) jsonObjectGithubWithService: (YOSService *) aService user:(NSString *) anUser
{
    
    return  [[self alloc] initWithService:aService user:anUser];
}

#pragma mark - Init

-(id) initWithService: (YOSService *) aService user:(NSString *) anUser
{
    if (self = [super init]) {
        _service = aService;
        _user = anUser;
        self.valid = YES;
        self.appDelegate = [[UIApplication sharedApplication] delegate];
        
        NSString *url = [NSString stringWithFormat:@"https://api.github.com/users/%@",anUser];
        
        id data = [self connectAPIGitHub:url];
        
        if (data) {
            [self processJSONUserData:data];
            url =[NSString stringWithFormat:@"https://api.github.com/users/%@/events",anUser];
            data =  [self connectAPIGitHub:url];
            [self  processJSONUserEvents:data];
        } else {
            self.valid = NO;
        }
        
    }
    return  self;
}


#pragma mark - Misc

-(void) processJSONUserData: (NSDictionary *) JSONUserData
{
    NSError *error;
    if (JSONUserData) {
        
        [YOSCredential credentialWithDictionary:JSONUserData
                                        context:self.appDelegate.stack.context];
    } else {
        NSLog(@"Error al parsear el JSON:%@ ", error.localizedDescription);
    }
    
}

-(void) processJSONUserEvents:(NSArray *) JSONUserEvents

{
    NSError *error;
    if (JSONUserEvents) {
        
        for (NSDictionary *dict in JSONUserEvents) {
            
            [YOSEvent eventWithDictionary:dict
                                  service:self.service
                                  context:self.appDelegate.stack.context];
        }
    } else {
        NSLog(@"Error al parsear el JSON:%@ ", error.localizedDescription);
    }
    
    
}

-(id) connectAPIGitHub: (NSString *) anUrl
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:anUrl]];
    NSURLResponse *response = [[NSURLResponse alloc] init];
    NSError *error;
    id JSONData;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    if (data) {
        
        if  ([anUrl containsString:@"events"]) {
            NSArray *dataUsers = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:kNilOptions
                                                                   error:&error];
            JSONData = dataUsers;
        } else {
            NSDictionary *eventUserData = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:kNilOptions
                                                                            error:&error];
            JSONData = eventUserData;
        }
        
        if ([JSONData count] == 2) {
            JSONData  = nil;
        }
    } else {
        NSLog(@"Error al cargar los datos del servidor:%@ ", error.localizedDescription);
    }
    
    return JSONData;
}

#pragma  mark - Misc

-(BOOL) verificValid {
    
    return  self.valid;
}

@end
