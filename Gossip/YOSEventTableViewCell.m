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

@implementation YOSEventTableViewCell



+(CGFloat)height {
    
    return 80.0f;
}


+(NSString *) cellId {
    return [self description];
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
