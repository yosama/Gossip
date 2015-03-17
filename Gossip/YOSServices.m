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
#import "Settings.h"


@implementation YOSServices




-(id) init {
    
    if (self = [super init]) {
        
        
        
        YOSPhotoContainer  *photoGit = [YOSPhotoContainer  insertInManagedObjectContext:STACK.context];
        photoGit.image = [UIImage imageNamed:@"octocat.png"];
        [YOSService serviceWithName:@"GitHub"
                             detail:@"the nerd's facebook"
                              photo: photoGit
                            context:STACK.context];
        
        YOSPhotoContainer  *photoGoogle = [YOSPhotoContainer  insertInManagedObjectContext:STACK.context];
        photoGoogle.image = [UIImage imageNamed:@"googleDrive.png"];
        [YOSService serviceWithName:@"Google Drive"
                             detail:@"Data store in the cloud 1"
                              photo:photoGoogle
                            context:STACK.context];
        
        YOSPhotoContainer  *photoDropbox = [YOSPhotoContainer  insertInManagedObjectContext:STACK.context];
        photoDropbox.image = [UIImage imageNamed:@"dropbox.png"];
        [YOSService serviceWithName:@"Dropbox"
                             detail:@"Data store in the cloud 2"
                              photo: photoDropbox
                            context:STACK.context];
        
        
        YOSPhotoContainer  *photoMendeley = [YOSPhotoContainer  insertInManagedObjectContext:STACK.context];
        photoMendeley.image = [UIImage imageNamed:@"mendeley.png"];
        [YOSService serviceWithName:@"Mendeley"
                             detail:@"Social Reference manager"
                              photo: photoMendeley
                            context:STACK.context];
        
        
        YOSPhotoContainer  *photoGoogleCalendar = [YOSPhotoContainer  insertInManagedObjectContext:STACK.context];
        photoGoogleCalendar.image = [UIImage imageNamed:@"calendar.png"];
        [YOSService serviceWithName:@"Google Calendar"
                             detail:@"Your calendars"
                              photo: photoGoogleCalendar
                            context:STACK.context];
        
        
        YOSPhotoContainer  *photoEvernote = [YOSPhotoContainer  insertInManagedObjectContext:STACK.context];
        photoEvernote.image = [UIImage imageNamed:@"evernote_logo_center_4c-sm.png"];
        [YOSService serviceWithName:@"Evernote"
                             detail:@""
                              photo: photoEvernote
                            context:STACK.context];
        
    }
    return self;
}

@end
