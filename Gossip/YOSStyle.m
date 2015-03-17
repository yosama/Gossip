//
//  YOSStyle.m
//  Gossip
//
//  Created by Yosnier on 13/03/15.
//  Copyright (c) 2015 YOS. All rights reserved.
//

@import UIKit;
#import "YOSStyle.h"
#import "YOSServiceTableViewCell.h"
#import "YOSEventTableViewCell.h"
#import "YOSServicesTableViewController.h"
#import "YOSEventsTableViewController.h"


@implementation YOSStyle


-(id) init
{
    //rgba(127, 140, 141,1.0)
    //rgba(44, 62, 80,1.0)
    //rgba(236, 240, 241,1.0)
    //rgba(41, 128, 185,1.0)
    
    //metroFont(81,81,81)
    //metrolightFont (238,238,238)
    //metroBackground(255,255,255)
    //metroButton (0,180,255)
    
    UIColor *cloudColor = [UIColor colorWithRed:236.0/255
                                          green:240.0/255.0
                                           blue:241.0/255.0
                                          alpha:1.0];
    
    UIColor *lightGray = [UIColor colorWithRed:199.0
                                         green:199.0
                                          blue:199.0
                                         alpha:1.0];
    
    UIColor *lightBlue = [UIColor colorWithRed:141.0/255
                                         green:160.0/255.0
                                          blue:177.0/255.0
                                         alpha:0.2];
    
    UIColor *fontBelizeHole = [UIColor colorWithRed:41.0/255
                                              green:128.0/255.0
                                               blue:185.0/255.0
                                              alpha:1.0];
    
    UIColor *metroFont = [UIColor colorWithRed:81.0/255.0
                                         green:81.0/255.0
                                          blue:81.0/255.0
                                         alpha:1.0];
    
    UIColor *metrolightFont = [UIColor colorWithRed:81/255.0
                                              green:81/255.0
                                               blue:81/255.0
                                              alpha:0.5];
    
    UIColor *metroBackground = [UIColor colorWithRed:255
                                               green:255
                                                blue:255
                                               alpha:1];
    
    UIColor *metroButton = [UIColor colorWithRed:0/255.0
                                           green:180.0/255.0
                                            blue:255.0
                                           alpha:1];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                metroFont,NSForegroundColorAttributeName,
                                [UIFont fontWithName:@"OpenSans-Regular"                                                                                  size:14.0],NSFontAttributeName
                                , nil];
    
    
    [[UINavigationBar appearance] setBackgroundColor:metrolightFont];
    
    [[UINavigationBar appearance] setTintColor:fontBelizeHole];
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
    
    [[YOSServiceTableViewCell appearance] setTintColor:[UIColor redColor]];

   
    
    
    
    
    
    
    return self;
}




@end
