#import "_YOSEvent.h"

@interface YOSEvent : _YOSEvent {}
// Custom logic goes here.

+(instancetype) eventWithDictionary:(NSDictionary *) aDict
                            service:(YOSService *) aService;

+(NSFetchedResultsController *) eventWithMOC: (NSManagedObjectContext *) aContext;

-(NSInteger) countEvents;
-(NSInteger) countEventsForService:(YOSService *) aService;

-(NSArray *) eventsForService:(YOSService *) aService;


@end
