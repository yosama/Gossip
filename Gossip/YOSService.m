#import "YOSService.h"
#import "YOSEvent.h"
#import "YOSPhotoContainer.h"

@interface YOSService ()



@end

@implementation YOSService

+(instancetype) serviceWithName: (NSString *) aName
                         detail: (NSString * ) aDetail
                        context:(NSManagedObjectContext *) aContext {
    
    YOSService *serv = [YOSService insertInManagedObjectContext:aContext];
    
    serv.name = aName;
    serv.detail = aDetail;
    serv.photo = [YOSPhotoContainer insertInManagedObjectContext:aContext];
    
    return serv;
}

@end
