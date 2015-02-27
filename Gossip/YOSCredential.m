#import "YOSCredential.h"
#import "YOSPhotoContainer.h"

@interface YOSCredential ()

// Private interface goes here.

@end

@implementation YOSCredential

+(instancetype) credentialWithUserId: (NSInteger ) anUserId
                                name:(NSString *) aName
                               photo:(YOSPhotoContainer *) aPhoto
                              detail: (NSString *) aDetail
                             context: (NSManagedObjectContext *) aContext {
    
    YOSCredential *crendential = [YOSCredential insertInManagedObjectContext:aContext];
    
    
    crendential.idUser = @(anUserId);
    crendential.name = aName;
    crendential.photo = aPhoto;
    crendential.detail = aDetail;
    
    return crendential;
}



@end
