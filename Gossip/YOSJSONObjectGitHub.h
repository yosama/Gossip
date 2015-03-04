//
//  YOSJSONObjectGitHub.h
//  Gossip
//
//  Created by Yosnier on 25/02/15.
//  Copyright (c) 2015 YOS. All rights reserved.
//

@import Foundation;
#import "AGTCoreDataStack.h"
#import "YOSService.h"
#import "AppDelegate.h"

@interface YOSJSONObjectGitHub : NSObject

@property (nonatomic,strong) NSDictionary *model;
@property (nonatomic,copy) NSString *user;
@property (nonatomic) BOOL userValid;
@property (nonatomic) BOOL userExists;


+(instancetype) jsonObjectGithubWithService: (YOSService *) aService user:(NSString *) anUser;

-(id) initWithService: (YOSService *) aService user:(NSString *) anUser;



@end
