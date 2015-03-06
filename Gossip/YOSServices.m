//
//  YOSServices.m
//  Gossip
//
//  Created by Yosnier on 05/03/15.
//  Copyright (c) 2015 YOS. All rights reserved.
//

#import "YOSServices.h"
#import "YOSService.h"
#import "YOSPhotoContainer.h"
#import "YOSAppDelegate.h"


@implementation YOSServices




-(id) init {
    
    if (self = [super init]) {
        
        YOSAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        
        YOSPhotoContainer  *photoGit = [YOSPhotoContainer  insertInManagedObjectContext:appDelegate.stack.context];
        photoGit.image = [UIImage imageNamed:@"octocat.png"];
        [YOSService serviceWithName:@"GitHub"
                             detail:@"the nerd's facebook"
                              photo: photoGit
                            context:appDelegate.stack.context];
        
        YOSPhotoContainer  *photoGoogle = [YOSPhotoContainer  insertInManagedObjectContext:appDelegate.stack.context];
        photoGoogle.image = [UIImage imageNamed:@"googleDrive.png"];
        [YOSService serviceWithName:@"Google Drive"
                             detail:@"Data store in the cloud 1"
                              photo:photoGoogle
                            context:appDelegate.stack.context];
        
        YOSPhotoContainer  *photoDropbox = [YOSPhotoContainer  insertInManagedObjectContext:appDelegate.stack.context];
        photoDropbox.image = [UIImage imageNamed:@"dropbox.png"];
        [YOSService serviceWithName:@"Dropbox"
                             detail:@"Data store in the cloud 2"
                              photo: photoDropbox
                            context:appDelegate.stack.context];
    }
    return self;
}

@end
