//
//  Settings.h
//  Gossip
//
//  Created by Yosnier on 05/03/15.
//  Copyright (c) 2015 YOS. All rights reserved.
//


#import "YOSAppDelegate.h"

#define GOOGLE_RESPONSE_NOTIFICATION @"googleResponseNotification"
#define GOOGLE_ERROR_NOTIFICATION @"googleErrorNotification"
#define GOOGLE_REVOKE_NOTIFICATION @"googleRevokeNotification"
#define GOOGLE_KEY @"keyResponse"

#define ENDPOINT_FOR_AUTHORIZATION @"https://accounts.google.com/o/oauth2/auth"
#define ENDPOINT_FOR_REVOCATION @"https://accounts.google.com/o/oauth2/revoke"
#define ENDPOINT_FOR_TOKEN @"https://accounts.google.com/o/oauth2/token"

#define GITHUB @"GitHub"
#define DROPBOX @"Dropbox"
#define GOOGLE @"Google Drive"
#define NEW_USER_NOTIFICATION @"newUser"
#define KEY @"keyUser"

#define CLIENT_ID @"184164577500-i9bdmc70ceolniavq71rt10ku124osti.apps.googleusercontent.com"
#define CLIENT_SECRET @"DchwgZRtwzubcQcjpr3xOGWs"
#define REDIRECT_URI @"urn:ietf:wg:oauth:2.0:oob"
#define SCOPES @"https://www.googleapis.com/auth/drive"


#define NEW_EVENT_SELECTED_NOTIFICATION @"newEventSelected"
#define KEY_EVENT_CHANGE @"newEvent"

#define AUTO_SAVE YES
#define AUTO_SAVE_DELAY 5


#define STACK ([(YOSAppDelegate *)[[UIApplication sharedApplication] delegate] stack])

