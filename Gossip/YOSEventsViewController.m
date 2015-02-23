//
//  YOSEventsViewController.m
//  Gossip
//
//  Created by Yosnier on 23/02/15.
//  Copyright (c) 2015 YOS. All rights reserved.
//

#import "YOSEventsViewController.h"

@interface YOSEventsViewController ()

@property (nonatomic,strong) YOSGoogleAuth *googleOauth;


@end

@implementation YOSEventsViewController

- (void)viewDidLoad {
    
        [super viewDidLoad];
        
        // Le decimos a la tabla que este controlador es su delegado y su fuente de datos.
    self
        [[self table] setDelegate:self];
        [[self table] setDataSource:self];
        
        // Iniciamos nuestra propiedad googleOauth con los datos correspondientes al servidor de autorización y al scope que vamos a consumir.
    self.googleOauth = [[YOSGoogleAuth alloc] initWithClientId:@"184164577500-i9bdmc70ceolniavq71rt10ku124osti.apps.googleusercontent.com"
                                                   clientSecret:@"DchwgZRtwzubcQcjpr3xOGWs"
                                                    redirectUri:@"urn:ietf:wg:oauth:2.0:oob"
                                                      forScopes:<#(NSArray *)#>
                                                     parentView:[self  ];
    
        
        // Avisamos al googleOauth de que este controlador es su delegado.
    
        [[self googleOauth] setGoogleOauthDelegate:self];
        
        // Instanciamos el array de calendarios.
        [self setCalendars:[[NSMutableArray alloc] init]];
        
        // Establecemos el botón Revoke como deshabilitado.
        [[self revokeButton] setEnabled:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnGrantAuthorization:(id)sender {
}

- (IBAction)btnRevokeAuthorization:(id)sender {
}
@end
