#import "_YOSEvent.h"

@interface YOSEvent : _YOSEvent {}
// Custom logic goes here.

+(instancetype) eventWithId: (NSInteger) aId
                       name:(NSString *) aName
                       type:(NSString *) aType
                        url:(NSString *) aUrl
                       date:(NSDate *)   aDate
                     detail:(NSString *) aDeatil
                    context: (NSManagedObjectContext *) aContext;
@end
