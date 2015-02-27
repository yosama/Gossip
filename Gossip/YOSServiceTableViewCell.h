//
//  YOSServiceTableViewCell.h
//  Gossip
//
//  Created by Yosnier on 23/02/15.
//  Copyright (c) 2015 YOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YOSServiceTableViewCell : UITableViewCell

+(NSString *) cellId;

+(CGFloat) height;



@property (weak, nonatomic) IBOutlet UILabel *lblNameService;

@property (weak, nonatomic) IBOutlet UILabel *lblDescriptionService;

@property (weak, nonatomic) IBOutlet UIImageView *imvPhotoService;







@end
