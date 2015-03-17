//
//  YOSWebViewController.h
//  Gossip
//
//  Created by Yosnier on 04/03/15.
//  Copyright (c) 2015 YOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YOSEvent.h"

@interface YOSWebViewController : UIViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *aivActivityIndicator;

@property (weak, nonatomic) IBOutlet UIWebView *wvBrowser;
@property (nonatomic, strong) YOSEvent *event;

-(id) initWithEvent:(YOSEvent *) anEvent;

@end
