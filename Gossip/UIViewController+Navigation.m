//
//  UIViewController+Navigation.m
//  Gossip
//
//  Created by Yosnier on 02/03/15.
//  Copyright (c) 2015 YOS. All rights reserved.
//

#import "UIViewController+Navigation.h"

@implementation UIViewController (Navigation)


-(UINavigationController *) wrapperNavigation {
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self];
    
    return nav;
}
@end
