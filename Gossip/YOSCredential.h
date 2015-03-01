#import "_YOSCredential.h"

@interface YOSCredential : _YOSCredential {}

+(instancetype) credentialWithDictionary: (NSDictionary *) aDictionary
                                 context: (NSManagedObjectContext *) aContext;

+(instancetype) credentialForIdUser:(NSInteger) anIdUser
                               context:(NSManagedObjectContext *) aContext;


@end
