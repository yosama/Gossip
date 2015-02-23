#import "YOSEvent.h"

@interface YOSEvent ()

// Private interface goes here.

@end

@implementation YOSEvent

+(instancetype) eventWithId: (NSInteger) aId
                       name:(NSString *) aName
                       type:(NSString *) aType
                        url:(NSString *) aUrl
                       date:(NSDate *)   aDate
                     detail:(NSString *) aDeatil
                    context: (NSManagedObjectContext *) aContext {
    
    YOSEvent *event = [YOSEvent insertInManagedObjectContext:aContext];
    event.name = aName;
    event.type = aType;
    event.url = aUrl;
    event.detail = aDeatil;
    event.date = aDate;
    
    

    return  event;

}

@end
