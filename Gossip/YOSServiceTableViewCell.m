//
//  YOSServiceTableViewCell.m
//  Gossip
//
//  Created by Yosnier on 23/02/15.
//  Copyright (c) 2015 YOS. All rights reserved.
//

#import "YOSServiceTableViewCell.h"
#import "YOSService.h"
#import "YOSPhotoContainer.h"

@interface YOSServiceTableViewCell()

@property (nonatomic, strong) YOSService *model;

@end

@implementation YOSServiceTableViewCell


-(void) setModel:(YOSService *) aModel {
    
    _model = aModel;
    
    self.lblNameService.text = self.model.name;
    self.lblDescriptionService.text = self.model.detail;
    
    
}

+(NSString *) cellId {
    
    return [self description];
}


+(CGFloat)height {
    
    return 70.0f;
}



- (void)awakeFromNib {
    // Initialization code
    
    
    
}








@end
