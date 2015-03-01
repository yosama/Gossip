#import "_YOSEvent.h"

@interface YOSEvent : _YOSEvent {}
// Custom logic goes here.

+(instancetype) eventWithDictionary:(NSDictionary *) aDict
                            service:(YOSService *) aService
                            context:(NSManagedObjectContext *) aContext;




@end
