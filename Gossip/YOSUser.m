#import "YOSUser.h"

@interface YOSUser ()

// Private interface goes here.

@end

@implementation YOSUser

// Custom logic goes here.



+(instancetype) userWithName: (NSString *) aName detail: (NSString *) aDetail context: (NSManagedObjectContext *) aContext {
    
    YOSUser *usr = [YOSUser insertInManagedObjectContext:aContext];
    
    usr.name = aName;
    usr.detail = aDetail;
}

@end
