#import "YOSService.h"
#import "YOSEvent.h"
#import "YOSPhotoContainer.h"

@interface YOSService ()



@end

@implementation YOSService

+(instancetype) serviceWithName: (NSString *) aName
                         detail: (NSString * ) aDetail
                          photo: (YOSPhotoContainer *) aPhoto
                        context:(NSManagedObjectContext *) aContext {
    
    YOSService *serv = [YOSService insertInManagedObjectContext:aContext];
    
    serv.name = aName;
    serv.detail = aDetail;
    serv.photo = aPhoto;
    
    return serv;
}





@end
