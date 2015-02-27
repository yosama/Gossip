//
//  YOSEventsTableViewCell.h
//  Gossip
//
//  Created by Yosnier on 23/02/15.
//  Copyright (c) 2015 YOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YOSEventTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imvPhotoService;
@property (weak, nonatomic) IBOutlet UIImageView *imvPhotoUser;

@property (weak, nonatomic) IBOutlet UILabel *lblTypeEvent;

@property (weak, nonatomic) IBOutlet UILabel *lblDescriptionEvent;

@property (weak, nonatomic) IBOutlet UILabel *lblUserDate;

@end
