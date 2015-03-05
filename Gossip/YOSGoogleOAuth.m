//
//  YOSGoogleOauth.m
//  Gossip
//
//  Created by Yosnier on 23/02/15.
//  Copyright (c) 2015 YOS. All rights reserved.
//

#import "YOSGoogleOAuth.h"
#import <AFNetworking/AFNetworking.h>

#define ENDPOINT_FOR_AUTHORIZATION @"https://accounts.google.com/o/oauth2/auth"
#define ENDPOINT_FOR_REVOCATION @"https://accounts.google.com/o/oauth2/revoke"
#define ENDPOINT_FOR_TOKEN @"https://accounts.google.com/o/oauth2/token"

@interface YOSGoogleOAuth ()

@property (nonatomic, strong) NSString *clientId;
@property (nonatomic, strong) NSString *clientSecret;
@property (nonatomic, strong) NSString *redirectUri;
@property (nonatomic, strong) NSArray *scopes;
@property (nonatomic, strong) UIView *parentView;
@property (nonatomic, strong) NSDictionary *token;
@property (nonatomic, strong) NSString *tokenDocumentPath;
@property (nonatomic, strong) UIActivityIndicatorView *aivActivityIndicator;
@property (nonatomic,strong) NSNotificationCenter *nc;


- (NSDictionary *)tokenizeParameters:(NSDictionary *)parameters;

- (NSString *)generatePayload:(NSDictionary *)parameters;
- (void)showAuthorizationView;

- (void)requestTokenWithCode:(NSString *)code
               thenOnSuccess:(RequestSuccess)successBlock
                 thenOnError:(RequestError)errorBlock;

- (void)refreshTokenThenOnSuccess:(RequestSuccess)successBlock
                      thenOnError:(RequestError)errorBlock;
- (BOOL)tokenHasExpired;
- (void)writeTokenDocument:(NSDictionary *)token;
- (NSDictionary *)readTokenDocument;





@end



@implementation YOSGoogleOAuth

#pragma mark - Designated Initializer

- (id) initWithClientId:(NSString *) aClientId
           clientSecret:(NSString *) aClientSecret
            redirectUri:(NSString *) aRedirectUri
              forScopes:(NSArray *) scopes
             parentView:(UIView *) aView {
    
    
    if (self = [super initWithFrame:[aView frame]]) {
        
        _clientId = aClientId;
        _clientSecret = aClientSecret;
        _redirectUri = aRedirectUri;
        _scopes = scopes;
        _parentView = aView;
        
        NSString *directory = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES ) objectAtIndex:0];
        self.tokenDocumentPath = [directory stringByAppendingString:@"/googletoken"];
        
        self.aivActivityIndicator = [[UIActivityIndicatorView alloc]
                                     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        
        
        
        self.aivActivityIndicator.center=_parentView.center;
        [self.aivActivityIndicator startAnimating];
        [_parentView addSubview:self.aivActivityIndicator];
        
    }
    return self;
    
}



#pragma mark - Util

- (NSString *)generatePayload:(NSDictionary *)parameters
{
    NSMutableString *payload = [NSMutableString stringWithString:@""];
    
    if ( [parameters count] > 0 ) {
        
        for ( NSString *key in [parameters allKeys] ) {
            
            [payload appendFormat:@"%@=%@&", key, [parameters objectForKey:key]];
        }
        
        payload = [NSMutableString stringWithString:[payload substringToIndex:[payload length] - 1]];
    }
    
    return [payload copy];
}

- (void)showAuthorizationView
{
    NSDictionary *parameters = @{ @"scope" : [self.scopes componentsJoinedByString:@"+"],
                                  @"redirect_uri":self.redirectUri,
                                  @"client_id" : self.clientId,
                                  @"response_type" : @"code" };
    
    NSString *authorizationUri = [NSString stringWithFormat:@"%@?%@", ENDPOINT_FOR_AUTHORIZATION, [self generatePayload:parameters]];
    
    self.delegate = self;
    self.scalesPageToFit = YES;
    self.autoresizingMask = [self.parentView autoresizingMask];
    
    [self loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:authorizationUri]]];
    [self.parentView addSubview:self];
}

- (void)requestTokenWithCode:(NSString *)code thenOnSuccess:(RequestSuccess)successBlock thenOnError:(RequestError)errorBlock
{
    NSDictionary *parameters = @{ @"code" : code,
                                  @"redirect_uri" :self.redirectUri,
                                  @"client_id" : self.clientId,
                                  @"client_secret" : self.clientSecret,
                                  @"grant_type" : @"authorization_code" };
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:ENDPOINT_FOR_TOKEN
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              self.token = responseObject;
              [self writeTokenDocument:responseObject];
              
              successBlock( responseObject );
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              errorBlock( error );
          }];
}

- (void)refreshTokenThenOnSuccess:(RequestSuccess)successBlock thenOnError:(RequestError)errorBlock
{
    NSDictionary *parameters = @{ @"refresh_token" : [self.token objectForKey:@"refresh_token"],
                                  @"client_id" : self.clientId,
                                  @"client_secret" : self.clientSecret,
                                  @"grant_type" : @"refresh_token" };
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:ENDPOINT_FOR_TOKEN
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              [self.token setValue:[responseObject objectForKey:@"access_token"]
                            forKey:@"access_token"];
              [self.token setValue:[responseObject objectForKey:@"expires_in"]
                            forKey:@"expires_in"];
              
              [self writeTokenDocument:self.token];
              
              successBlock( responseObject );
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              errorBlock( error );
          }];
}

- (BOOL)tokenHasExpired
{
    BOOL expired;
    NSError *error = nil;
    NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:self.tokenDocumentPath
                                                                                error:&error];
    if ( error ) {
        
        expired = YES;
    }
    else {
        
        NSDate *creation = [attributes fileCreationDate];
        expired = [[NSDate date] timeIntervalSinceDate:creation] >= [[[self token] objectForKey:@"expires_in"] intValue];
    }
    
    return expired;
}

- (void)writeTokenDocument:(NSDictionary *)token
{
    [token writeToFile:self.tokenDocumentPath
            atomically:YES];
}

- (NSDictionary *)readTokenDocument
{
    return [NSDictionary dictionaryWithContentsOfFile:self.tokenDocumentPath];
}


#pragma mark - WebViewDelegate


- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.aivActivityIndicator setHidden:NO];
    [self.aivActivityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.aivActivityIndicator stopAnimating];
    [self.aivActivityIndicator setHidden:YES];
    
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    if ( [title rangeOfString:@"Success"].location != NSNotFound ) {
        
        NSString *code = [[title componentsSeparatedByString:@"="] objectAtIndex:1];
        
        [self loadHTMLString:@"<html><head><title>Please wait</title></head><body><h1>Retrieving the token...</h1></body></html>"
                     baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
        
        RequestSuccess onSuccess = ^(id response) {
            
            [webView removeFromSuperview];
          
            [self sendNotificationResponse:response];
            
            [self.delegate authorizationGranted];
        };
        
        RequestError onError = ^(NSError *error) {
            
            [self sendNotificationError:error];
            
            [self.delegate errorOcurred:error];
        };
        
        [self requestTokenWithCode:code
                     thenOnSuccess:onSuccess
                       thenOnError:onError];
    }
    else if ( [title rangeOfString:@"access_denied"].location != NSNotFound ) {
        
        [webView removeFromSuperview];
    }
}

#pragma mark - OAuth2

- (void)grantAuthorization
{
    
    if ( [[NSFileManager defaultManager] fileExistsAtPath:self.tokenDocumentPath] ) {
        
        self.token = [self readTokenDocument];
        
        if ( [self tokenHasExpired] ) {
            
            RequestSuccess onSuccess = ^(id response) {
                
                [self sendNotificationResponse:response];
        
                [self.delegate authorizationGranted];
            };
            
            RequestError onError = ^(NSError *error) {
                
                [self sendNotificationError:error];
                [self.delegate errorOcurred:error];
            };
            
            [self refreshTokenThenOnSuccess:onSuccess
                                thenOnError:onError];
        } else {
            
            [self.delegate authorizationGranted];
        }
    } else {
        
        [self showAuthorizationView];
    }
}

- (void)revokeAuthorization
{
    NSDictionary *parameters = @{ @"token" : [self.token objectForKey:@"access_token"] };
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:ENDPOINT_FOR_REVOCATION
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              self.token = nil;
              [[NSFileManager defaultManager] removeItemAtPath:self.tokenDocumentPath
                                                         error:nil];
              
              [self sendNotificationRevoke:responseObject];
              
              [self.delegate authorizationRevoke];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              [self sendNotificationError:error];
              [self.delegate errorOcurred:error];
          }];
}


#pragma  mark - HTTP Request

- (void)doGetRequest:(NSString *)url
      withParameters:(NSDictionary *)parameters
       thenOnSuccess:(RequestSuccess)successBlock
         thenOnError:(RequestError)errorBlock
{    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:url
      parameters:[self tokenizeParameters:parameters]
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             successBlock( responseObject );
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             errorBlock( error );
         }];
}

- (void)doPostRequest:(NSString *)url
       withParameters:(NSDictionary *)parameters
        thenOnSuccess:(RequestSuccess)successBlock
          thenOnError:(RequestError)errorBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:url
       parameters:[self tokenizeParameters:parameters]
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              successBlock( responseObject );
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              errorBlock( error );
          }];
}

- (void)doPutRequest:(NSString *)url
      withParameters:(NSDictionary *)parameters
       thenOnSuccess:(RequestSuccess)successBlock
         thenOnError:(RequestError)errorBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager PUT:url
      parameters:[self tokenizeParameters:parameters]
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             successBlock( responseObject );
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             errorBlock( error );
         }];
}

- (void)doDeleteRequest:(NSString *)url
         withParameters:(NSDictionary *)parameters
          thenOnSuccess:(RequestSuccess)successBlock
            thenOnError:(RequestError)errorBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager DELETE:url
         parameters:[self tokenizeParameters:parameters]
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                successBlock( responseObject );
            }
            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                errorBlock( error );
            }];
}

#pragma mark - Misc

- (NSDictionary *)tokenizeParameters:(NSDictionary *)parameters
{
    NSMutableDictionary *tokenized = parameters == nil
    ? [[NSMutableDictionary alloc] init]
    : [NSMutableDictionary dictionaryWithDictionary:parameters];
    
    [tokenized setValue:[self.token objectForKey:@"access_token"]
                 forKey:@"access_token"];
    
    return [tokenized copy];
}

-(void) sendNotificationResponse:(id) object
{
    NSNotification *notify = [NSNotification notificationWithName:GOOGLE_RESPONSE_NOTIFICATION
                                                           object:self
                                                         userInfo:@{GOOGLE_KEY:object}];
    [self.nc postNotification:notify];
}

-(void) sendNotificationError: (id) object
{
    NSNotification *notify = [NSNotification notificationWithName:GOOGLE_ERROR_NOTIFICATION
                                                           object:self
                                                         userInfo:@{GOOGLE_KEY:object}];
    [self.nc postNotification:notify];
}

-(void) sendNotificationRevoke: (id) object
{
    NSNotification *notify = [NSNotification notificationWithName:GOOGLE_REVOKE_NOTIFICATION
                                                           object:self
                                                         userInfo:@{GOOGLE_KEY:object}];
    [self.nc postNotification:notify];
}




@end
