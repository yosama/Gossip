//
//  YOSWebViewController.h
//  Gossip
//
//  Created by Yosnier on 04/03/15.
//  Copyright (c) 2015 YOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YOSWebViewController : UIViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *aivActivityIndicator;

@property (weak, nonatomic) IBOutlet UIWebView *wvBrowser;
@property (nonatomic, strong) NSString *url;

-(id) initWithURL:(NSString *) anUrl;

@end
