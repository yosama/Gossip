#import "YOSCredential.h"

@interface YOSCredential ()

// Private interface goes here.

@end

@implementation YOSCredential

+(instancetype) userWithName: (NSString *) aName detail: (NSString *) aDetail context: (NSManagedObjectContext *) aContext {
    
    YOSCredential *crendential = [YOSCredential insertInManagedObjectContext:aContext];
    
    crendential.name = aName;
    crendential.detail = aDetail;
    
    return crendential;
}


@end
