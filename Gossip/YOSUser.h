#import "_YOSUser.h"

@interface YOSUser : _YOSUser {}
// Custom logic goes here.

+(instancetype) userWithName: (NSString *) aName detail: (NSString *) aDetail context: (NSManagedObjectContext *) aContext;

@end
