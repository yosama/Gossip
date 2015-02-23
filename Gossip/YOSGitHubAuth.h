//
//  YOSJSONGitHub.h
//  Gossip
//
//  Created by Yosnier on 23/02/15.
//  Copyright (c) 2015 YOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YOSGitHubAuth : NSObject 

@property (nonatomic,strong) NSDictionary *model;
@property (copy) NSString *user;

//-(id) initWithDictionary :(NSDictionary *) aDictionary;

-(id) initWithUser: (NSString *) anUser;

-(void) showData;


@end
