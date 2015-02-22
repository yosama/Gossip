//
//  YOSJsonToObject.m
//  Gossip
//
//  Created by Yosnier on 17/02/15.
//  Copyright (c) 2015 YOS. All rights reserved.
//

#import "YOSJSONToObject.h"

@implementation YOSJSONToObject



-(id) initWithUser: (NSString *) aUser {
    
    if (self = [super init]) {
        
        aUser = @"yosamac";
        
        NSString *url = [NSString stringWithFormat:@"https://api.github.com/users/%@/events",aUser];
        
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
