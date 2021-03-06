#import "_YOSService.h"
@import UIKit;

@interface YOSService : _YOSService {}
// Custom logic goes here.

+(instancetype) serviceWithName: (NSString *) aName
                         detail: (NSString *) aDetail
                          photo: (YOSPhotoContainer *)  aPhoto
                        context: (NSManagedObjectContext *) aContext;

+(instancetype) serviceForNameService:(NSString *) aNameService
                              context:(NSManagedObjectContext *) aContext;

+(NSFetchedResultsController *) serviceWithContext: (NSManagedObjectContext *) aContext;


-(NSInteger) countServices;
@end
