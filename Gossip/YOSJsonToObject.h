//
//  YOSJsonToObject.h
//  Gossip
//
//  Created by Yosnier on 17/02/15.
//  Copyright (c) 2015 YOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YOSJsonToObject : NSObject

@property (nonatomic,strong) NSDictionary *model;

-(id) initWithDictionary :(NSDictionary *) aDictionary;


@end
