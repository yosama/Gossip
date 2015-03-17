//
//  YOSWebViewController.m
//  Gossip
//
//  Created by Yosnier on 04/03/15.
//  Copyright (c) 2015 YOS. All rights reserved.
//

#import "YOSWebViewController.h"
#import "YOSEventsTableViewController.h"
#import "Settings.h"

@interface YOSWebViewController ()

@end

@implementation YOSWebViewController


#pragma mark - Init

-(id) initWithEvent:(YOSEvent *) anEvent
{
    if (self = [super init]) {
        _event = anEvent;
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.wvBrowser.delegate = self;
    
    [self loadPage];
    [self.aivActivityIndicator startAnimating];

}


-(void) viewWillAppear:(BOOL)animated
{
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(eventDidChange:)
               name:NEW_EVENT_SELECTED_NOTIFICATION
             object:nil];
    
    self.title = self.event.name;
}

-(void) viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Util

-(void) loadPage
{
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:self.event.url]];
    
    [self.wvBrowser loadRequest:req];
}


#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.aivActivityIndicator setHidden:NO];
    [self.aivActivityIndicator startAnimating];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [self.aivActivityIndicator stopAnimating];
    [self.aivActivityIndicator setHidden:YES];
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.aivActivityIndicator stopAnimating];
    [self.aivActivityIndicator setHidden:YES];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:[error localizedDescription]
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"OK", nil];
    [alert show];
}


#pragma mark - Notification

- (void) eventDidChange: (NSNotification *) aNotification
{
    NSDictionary *dict = [aNotification userInfo];
    self.event.url = [dict objectForKey:KEY_EVENT_CHANGE];
    
    [self loadPage];
}


@end
