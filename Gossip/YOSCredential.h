#import "_YOSCredential.h"

@interface YOSCredential : _YOSCredential {}

+(instancetype) credentialWithUserId: (NSInteger ) anUserId
                                name:(NSString *) aName
                               photo:(YOSPhotoContainer *) aPhoto
                            detail: (NSString *) aDetail
                           context: (NSManagedObjectContext *) aContext;


@end
