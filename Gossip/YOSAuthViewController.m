//
//  YOSGitHubAuthViewController.m
//  Gossip
//
//  Created by Yosnier on 25/02/15.
//  Copyright (c) 2015 YOS. All rights reserved.
//


#import "YOSAuthViewController.h"
#import "YOSPhotoContainer.h"
#import "YOSCredential.h"
#import "YOSJSONObjectGitHub.h"
#import "YOSEventsTableViewController.h"
#import "UIViewController+Navigation.h"
#import "YOSGoogleOAuth.h"
#import "Settings.h"

@interface YOSAuthViewController ()

@property (nonatomic, strong) NSDictionary *services;
@property (nonatomic, strong) YOSGoogleOAuth *googleOAuth;

@end

@implementation YOSAuthViewController


#pragma mark - Init


-(id) initWithService: (YOSService *) aService
{
    if (self = [super init]) {
        _service = aService;
    }
    
    return  self;
}


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.imvLogoService.image = self.service.photo.image;
    self.txfUser.delegate = self;
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self
           selector:@selector(authorizationGranted)
               name:GOOGLE_RESPONSE_NOTIFICATION
             object:nil];
    
    [nc addObserver:self
           selector:@selector(errorOccured:)
               name:GOOGLE_ERROR_NOTIFICATION
             object:nil];
    
    
    self.title = self.service.name;

}

-(void) viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if ([self.service.name isEqualToString:GOOGLE]) {
        
        self.googleOAuth = [[YOSGoogleOAuth alloc] initWithClientId:CLIENT_ID
                                                       clientSecret:CLIENT_SECRET
                                                        redirectUri:REDIRECT_URI
                                                          forScopes:@[SCOPES]
                                                         parentView:self.view];
        [self.googleOAuth grantAuthorization];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Actions

- (IBAction)btnSingin:(id)sender
{
    if ([self validateField] == YES) {
        [self callEventsForService];
    }

}


-(void) callEventsForService
{
    if ([self.service.name isEqualToString:DROPBOX]) {
        
        NSLog(@"Implementando modulo");
        
    } else if ([self.service.name isEqualToString:GITHUB]) {
        
        YOSJSONObjectGitHub *jsonObject = [[YOSJSONObjectGitHub alloc ]initWithService:self.service
                                                                                  user:self.txfUser.text];
        
        if ([jsonObject userValid] == NO) {
            [self showAlertError:@"Error" message:@"User no valid"];
            
        } else if ([jsonObject userExists] == YES) {
            [self showAlertError:@"Error" message:@"User exists"];
            
        } else {
            
            YOSAppDelegate *appDel = [[UIApplication sharedApplication] delegate];
            
            NSFetchedResultsController *frc =   [YOSEvent eventWithMOC:appDel.stack.context];
            
            YOSEventsTableViewController *eventTVC = [[YOSEventsTableViewController alloc]initWithFetchedResultsController:frc
                                                                                                                     style:UITableViewStylePlain];
            
            NSNotification *notify = [NSNotification notificationWithName:NEW_USER_NOTIFICATION
                                                                   object:self
                                                                 userInfo:@{KEY:frc}];
            [NSNotificationCenter.defaultCenter postNotification:notify];
            
            [self.navigationController pushViewController:eventTVC
                                                 animated:YES];
        }
        
        
    } else if ([self.service.name isEqualToString:GOOGLE]) {
        
        
        
    }
    
}


-(BOOL) validateField
{
    BOOL result;
    if([self.txfUser.text length] == 0) {
        [self showAlertError:@"Error"
                     message:@"Type an user and password"];
        result = NO;
    }else {
        result = YES;
    }
    
    return result;
}


#pragma mark - TextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // El usuario le ha dado a into
    // ¿LO damos por bueno?
    // Valimos el texto y si está bien, entonces...
    
    [self validateField];
    
    [textField resignFirstResponder];
    
    return YES;
    
}

//-(void) textFieldDidEndEditing:(UITextField *)textField
//{
//    [self callEventsForService];
//    
//}

-(IBAction)removeKeyBoard:(id)sender
{
    // keyboard hide
    [self.view endEditing:YES];
    
}


#pragma mark - Misc

-(void) showAlertError: (NSString *) aTitle message: (NSString *) aMessage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:aTitle
                                                    message:aMessage
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"OK", nil];
    [alert show];
    
}


#pragma mark - Notifications GoogleOAuth

- (void)authorizationGranted
{
    NSLog( @"Authorization granted" );
    
    // Definimos el bloque encargado de manejar las peticiones de calendarios satisfactorias.
    // Lo que hacemos es almacenar la respuesta en el array que definimos previamente y recargar la tabla para mostrarlos.
    RequestSuccess onSuccess = ^(id response) {
        
        //        [[self calendars] addObjectsFromArray:[response objectForKey:@"items"]];
        //
        NSLog( @"Success" );
        //
        //        [[self table] reloadData];
    };
    
    // Definimos el bloque encargado de manejar las peticiones de calendarios fallidas.
    RequestError onError = ^(NSError *error) {
        
        NSLog( @"Error occured: %@", [error localizedDescription] );
    };
    
    [self.googleOAuth doGetRequest:@"https://www.googleapis.com/calendar/v3/users/me/calendarList"
                    withParameters:nil
                     thenOnSuccess:onSuccess
                       thenOnError:onError];
}

- (void)authorizationRevoked
{
    NSLog( @"Authorization revoked" );
    
    // Limpiamos el array de calendarios y vaciamos la tabla.
    //    [[self calendars] removeAllObjects];
    //    [[self table] reloadData];
    //
    //    // Habilitamos el botón Grant, y deshabilitamos Revoke.
    //    [[self grantButton] setEnabled:YES];
    //    [[self revokeButton] setEnabled:NO];
}

- (void)errorOccured:(NSError *)error
{
    NSLog( @"Error occured: %@", [error localizedDescription] );
}





@end
