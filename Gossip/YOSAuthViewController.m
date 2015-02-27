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


@interface YOSAuthViewController ()

@property (nonatomic, strong) NSDictionary *services;

@end

@implementation YOSAuthViewController


#pragma mark - Init


-(id) initWithService: (YOSService *) aService {
    
    if (self = [super init]) {
        _service = aService;
    }
    
    return  self;
}


- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.imvLogoService.image = self.service.photo.image;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.txfUser.delegate = self;
    self.txfPassword.delegate = self;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    // El usuario le ha dado a into
    // ¿LO damos por bueno?
    
    // Valimos el texto y si está bien, entonces...
    [textField resignFirstResponder];
    [self validateField];
    return YES;
    
}

-(void) textFieldDidEndEditing:(UITextField *)textField{
    
    // El tio ha terminado de editar y YA HEMOS VALIDADO
    // Momento de guardar el texto en algun lugar
    [self callEventsForService];
   
}


-(IBAction)removeKeyBoard:(id)sender{
    
    // aquí hago desaparecer el teclado
    [self.view endEditing:YES];
    
    
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



- (IBAction)btnSingin:(id)sender {
    
    [self callEventsForService];
    
}


-(void) callEventsForService {
    
    
    if ([self.service.name isEqualToString:DROPBOX]) {
        
        NSLog(@"Implementando modulo");
        
    } else if ([self.service.name isEqualToString:GITHUB]) {
        
        YOSJSONObjectGitHub *objectsGithub = [[YOSJSONObjectGitHub alloc] initWithService:self.service
                                                                                     user:self.txfUser.text];
        [objectsGithub fillCoreDataObjectsModels];

        
    } else if ([self.service.name isEqualToString:GOOGLE]) {
        NSLog(@"Implementando modulo");
    }

}



-(void) validateField {
    if([self.txfUser.text length] == 0) {
        [self showAlertByInfo:@"Error" message:@"Type an user or password"];
    } else if([self.txfPassword.text length] == 0) {
        [self showAlertByInfo:@"Error" message:@"Type an user or password"];
    }
}



- (void) showAlertByInfo:(NSString *) aInfo message:(NSString *) aMessage{
    
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




@end
