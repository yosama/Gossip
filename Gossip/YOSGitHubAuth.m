//
//  YOSJSONGitHub.m
//  Gossip
//
//  Created by Yosnier on 23/02/15.
//  Copyright (c) 2015 YOS. All rights reserved.
//

#import "YOSGitHubAuth.h"

@implementation YOSGitHubAuth


-(id) initWithUser: (NSString *) anUser {
    
    if (self = [super init]) {
        
        
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
                    
                    _model = dict;
                    
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



-(void) showData {
    
    NSLog(@"Datos usuario: %@ ",[self.model objectForKey:@"actor:"]);
    
}


@end
