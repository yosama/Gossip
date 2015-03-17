//
//  YOSEventTableViewCell.m
//  Gossip
//
//  Created by Yosnier on 23/02/15.
//  Copyright (c) 2015 YOS. All rights reserved.
//

#import "YOSEventTableViewCell.h"
#import "YOSCredential.h"
#import "YOSService.h"
#import "UIImage+RoundedCorner.h"
#import "UIImage+Resize.h"
@implementation YOSEventTableViewCell




+(CGFloat)height
{
    return 90.0f;
}

+(NSString *) cellId
{
    return [self description];
}

-(void) viewWillAppear:(BOOL)animated
{
    self.imvPhotoUser.layer.cornerRadius = self.imvPhotoUser.frame.size.width/2;
    
}



@end
