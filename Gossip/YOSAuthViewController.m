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


@interface YOSAuthViewController ()

@property (nonatomic, strong) NSDictionary *services;

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
    
    //    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    //    [nc addObserver:self
    //           selector:@selector(callEventsForService)
    //               name:NOTIFICATION_USER
    //             object:nil];
    
}

-(void) viewWillDisappear:(BOOL)animated
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Actions

- (IBAction)btnSingin:(id)sender
{
    [self callEventsForService];
    
}


-(void) callEventsForService
{
    if ([self.service.name isEqualToString:DROPBOX]) {
        
        NSLog(@"Implementando modulo");
        
    } else if ([self.service.name isEqualToString:GITHUB]) {
        
        YOSJSONObjectGitHub *jsonObject = [[YOSJSONObjectGitHub alloc ]initWithService:self.service
                                                                                  user:self.txfUser.text];
        
        if ([jsonObject verificValid] == NO) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"User no valid"
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK", nil];
            [alert show];
            
        } else {
            
            AppDelegate *appDel = [[UIApplication sharedApplication] delegate];
            
            NSFetchedResultsController *frc =   [YOSEvent eventWithMOC:appDel.stack.context];
            
            YOSEventsTableViewController *eventTVC = [[YOSEventsTableViewController alloc]init];
            self.delegate = eventTVC;
            [self.delegate authViewController:self
                        fetchResultController:frc];
            
            NSNotification *notify = [NSNotification notificationWithName:NEW_USER_NOTIFICATION
                                                                   object:self
                                                                 userInfo:@{KEY:frc}];
            [NSNotificationCenter.defaultCenter postNotification:notify];
            
            [self.navigationController pushViewController:eventTVC
                                                 animated:YES];
        }
        
        
    } else if ([self.service.name isEqualToString:GOOGLE]) {
        NSLog(@"Implementando modulo");
    }
    
}


-(void) validateField
{
    if([self.txfUser.text length] == 0) {
        [self showAlertByInfo:@"Error" message:@"Type an user valid"];
    }
    
}

- (void) showAlertByInfo:(NSString *) aInfo message:(NSString *) aMessage
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:aInfo
                                                                   message:aMessage
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    // Button OK
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK"
                                                 style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction *action){
                                                   
                                                   [alert dismissViewControllerAnimated:YES completion:nil];
                                               }];
    
    // Button Cancel
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction *action){
                                                       
                                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                                   }];
    
    // Add buttons [ok,cancel]
    [alert addAction:ok];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
    
}

#pragma mark - TextFieldDelegate


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // El usuario le ha dado a into
    // ¿LO damos por bueno?
    // Valimos el texto y si está bien, entonces...
    
    [textField resignFirstResponder];
    
    return YES;
    
}

-(void) textFieldDidEndEditing:(UITextField *)textField
{
    [self callEventsForService];
    
}


-(IBAction)removeKeyBoard:(id)sender
{
    // keyboard hide
    [self.view endEditing:YES];
    
}



@end
