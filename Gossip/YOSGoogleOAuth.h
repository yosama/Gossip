//
//  YOSGoogleOauth.h
//  Gossip
//
//  Created by Yosnier on 23/02/15.
//  Copyright (c) 2015 YOS. All rights reserved.
//

#define GOOGLE_RESPONSE_NOTIFICATION @"googleResponseNotification"
#define GOOGLE_ERROR_NOTIFICATION @"googleErrorNotification"
#define GOOGLE_REVOKE_NOTIFICATION @"googleRevokeNotification"
#define GOOGLE_KEY @"keyResponse"

#import <UIKit/UIKit.h>



@protocol YOSGoogleOAuthDelegate <NSObject>

-(void) authorizationGranted;
-(void) authorizationRevoke;
-(void) errorOcurred:(NSError *) anError;

@end

@interface YOSGoogleOAuth : UIWebView <UIWebViewDelegate>

//Delegate
@property (weak) id<YOSGoogleOAuthDelegate> delegate;

//Designated initializer
- (id) initWithClientId:(NSString *) aClientId
           clientSecret:(NSString *) aClientSecret
            redirectUri:(NSString *) aRedirectUri
              forScopes:(NSArray *)scopes
             parentView:(UIView *) aView;

-(void) grantAuthorization;
-(void) revokeAuthorization;

typedef void (^ RequestSuccess)(id);
typedef void (^ RequestError)(NSError *) ;


- (void)doGetRequest:(NSString *)url
      withParameters:(NSDictionary *)parameters
       thenOnSuccess:(RequestSuccess)successBlock
         thenOnError:(RequestError)errorBlock;

- (void)doPostRequest:(NSString *)url
       withParameters:(NSDictionary *)parameters
        thenOnSuccess:(RequestSuccess)successBlock
          thenOnError:(RequestError)errorBlock;

- (void)doPutRequest:(NSString *)url
      withParameters:(NSDictionary *)parameters
       thenOnSuccess:(RequestSuccess)successBlock
         thenOnError:(RequestError)errorBlock;

- (void)doDeleteRequest:(NSString *)url
         withParameters:(NSDictionary *)parameters
          thenOnSuccess:(RequestSuccess)successBlock
            thenOnError:(RequestError)errorBlock;


@end
