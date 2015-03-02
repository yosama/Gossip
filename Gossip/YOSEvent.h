#import "_YOSEvent.h"

@interface YOSEvent : _YOSEvent {}
// Custom logic goes here.

+(instancetype) eventWithDictionary:(NSDictionary *) aDict
                            service:(YOSService *) aService
                            context:(NSManagedObjectContext *) aContext;

+(NSFetchedResultsController *) eventWithMOC: (NSManagedObjectContext *) aContext;

-(NSInteger) countEvents:(NSManagedObjectContext *) aContext;
-(NSInteger) countEventsForService:(YOSService *) aService
                           context:(NSManagedObjectContext *) aContext;

-(NSArray *) eventsForService:(YOSService *) aService
                      context:(NSManagedObjectContext *) aContext;


@end
