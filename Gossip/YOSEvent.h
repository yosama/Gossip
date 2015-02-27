#import "_YOSEvent.h"

@interface YOSEvent : _YOSEvent {}
// Custom logic goes here.

+(instancetype) eventWithId: (NSInteger) aId
                       name:(NSString *) aName
                       type:(NSString *) aType
                        url:(NSString *) aUrl
                       date:(NSDate *)   aDate
                     detail:(NSString *) aDeatil
                    service:(YOSService *) aService
                       user:(YOSCredential *)aCredential
                    context: (NSManagedObjectContext *) aContext;


@property (nonatomic,strong) NSDictionary *events;

-(id) initWithDictionary: (NSDictionary *) aDict;


@end
