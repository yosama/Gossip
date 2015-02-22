@import UIKit;
#import "YOSPhotoContainer.h"


@interface YOSPhotoContainer ()

// Private interface goes here.

@end

@implementation YOSPhotoContainer

// Custom logic goes here.

-(UIImage *) image {
    return [UIImage imageWithData:self.photoData];
    
}


-(void) setImage:(UIImage *)image {
    
    self.photoData =UIImageJPEGRepresentation(image, 0.9);
}


@end
