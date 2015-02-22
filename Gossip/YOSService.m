#import "YOSService.h"
#import "YOSEvent.h"

@interface YOSService ()

// Private interface goes here.

@end

@implementation YOSService

+(instancetype) serviceWithName: (NSString *) aName
                         detail: (NSString * ) aDetail
                        context:(NSManagedObjectContext *) aContext {
    
    YOSService *serv = [YOSService insertInManagedObjectContext:aContext];
    
    serv.name = aName;
    serv.detail = aDetail;
    serv.event = [YOSEvent insertInManagedObjectContext:aContext];
    
serv.user = [YOSUser]
    return serv;
}

@end
