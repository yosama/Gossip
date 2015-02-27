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
        
        NSString *url = [NSString stringWithFormat:@"https://api.github.com/users/%@/events",anUser];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        
        NSURLResponse *response = [[NSURLResponse alloc] init];
        NSError *err;
        
        NSData *data = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:&response
                                                         error:&err];
        
        if (data) {
            
            NSArray *JSONObjects = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:kNilOptions
                                                                     error:&err];
            if (JSONObjects) {
                
                for (NSDictionary *dict in JSONObjects) {
                    
                    = dict;
                    
                }
                
            } else {
                NSLog(@"Error al parsear el JSON :%@ ", err.localizedDescription);
            }
            
        } else {
            NSLog(@"Error al cargar los datos del servidor:%@ ", err.localizedDescription);
        }
        
    }
    return  self;
}



-(void) fillCoreDataObjectsModels {
    
    AppDelegate *appDel= [[UIApplication sharedApplication] delegate];
    
    // filling  credential entity
    NSDictionary *actor = [self.model objectForKey:@"actor"];
    NSInteger userId = [[actor objectForKey:@"id"] integerValue];
    NSString *userName = [actor objectForKey:@"name"];
    YOSPhotoContainer *photoCon = [YOSPhotoContainer insertInManagedObjectContext:appDel.stack.context];
    
    photoCon.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[actor objectForKey:@"avatar_url"]]]];
    NSString *detail = [actor objectForKey:@"url"];
    
    YOSCredential *credential = [YOSCredential credentialWithUserId:userId
                                                               name:userName
                                                              photo: photoCon
                                                             detail:detail
                                                            context:appDel.stack.context];
    
    // filling event entity
    NSInteger eventId = [[self.model objectForKey:@"id"] integerValue];
    NSDictionary *payload = [self.model objectForKey:@"payload"];
    NSDictionary *commits = [payload objectForKey:@"commits"];
    NSString *message = [commits objectForKey:@"message"];
    NSString *type = [self.model objectForKey:@"type"];
    NSDateFormatter *df = [NSDateFormatter new];
    NSDate *createDate = [df dateFromString:[self.model objectForKey:@"created_at"]];
    NSString *url = [commits objectForKey:@"url"];
    NSDictionary *authorDict = [commits objectForKey:@"author"];
    NSString *author = [authorDict objectForKey:@"name"];
    
    YOSEvent *event = [YOSEvent eventWithId:eventId
                                       name:message
                                       type:type
                                        url:url
                                       date:createDate
                                     detail:author
                                    service:self.service
                                       user:credential
                                    context:appDel.stack.context ];
    
}




-(void) showData {
    
    NSLog(@"Datos usuario: %@ ",[self.model objectForKey:@"actor:"]);
    
}




@end
