//
//  YOSJsonToObject.m
//  Gossip
//
//  Created by Yosnier on 17/02/15.
//  Copyright (c) 2015 YOS. All rights reserved.
//

#import "YOSJsonToObject.h"

@implementation YOSJsonToObject



-(id) initWithDictionary :(NSDictionary *) aDictionary {
    
    
    
    if (self = [super init]) {
        
        NSURLRequest *req = [NSURLRequest requestWithURL:@""]
        
        
        [[NSJSONSerialization init] a]
        _model = aDictionary;
    }
    
    return  self;
}





@end
