#import "YOSEvent.h"
#import "YOSService.h"
#import "YOSPhotoContainer.h"
#import "YOSCredential.h"

@interface YOSEvent ()

@end

@implementation YOSEvent

#pragma mark - Methods class

+(instancetype) eventWithDictionary:(NSDictionary *) aDict
                            service:(YOSService *) aService
                            context:(NSManagedObjectContext *) aContext
{
    NSInteger eventId = [[aDict objectForKey:@"id"] integerValue] ;
    NSDictionary *payload = [aDict objectForKey:@"payload"];
    NSArray *commits = [payload objectForKey:@"commits"];
    
    NSString *message = nil;
    NSString *url = nil;
    NSDictionary *authorDict = nil;
    
    for (NSDictionary *dict in commits) {
        message = [dict objectForKey:@"message"];
        url = [dict objectForKey:@"url"];
        authorDict = [dict objectForKey:@"author"];
    }
    
    NSString *type = [aDict objectForKey:@"type"];
    NSDateFormatter *df = [NSDateFormatter new];
    NSDate *createDate = [df dateFromString:[aDict objectForKey:@"created_at"]];
    NSString *author = [authorDict objectForKey:@"name"];
    
    YOSEvent *event = [YOSEvent insertInManagedObjectContext:aContext];
    
    event.idEvent = @(eventId);
    event.name = message;
    event.typeEvent = type;
    event.url = url;
    event.detail = author;
    event.date = createDate;
    event.service = aService;
    
    NSInteger idUser = [[[NSDictionary dictionaryWithDictionary:[aDict objectForKey:@"actor"] ] objectForKey:@"id"] integerValue];
    
    event.user = [YOSCredential credentialForIdUser:idUser context:aContext];
    
    return event;
}


+(NSFetchedResultsController *) showAllEvents: (NSManagedObjectContext *) aContext {
    
    NSFetchRequest *reqEvents = [NSFetchRequest fetchRequestWithEntityName:[YOSEvent entityName]];
    reqEvents.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:YOSEventAttributes.typeEvent
                                                                ascending:YES],
                                  [NSSortDescriptor sortDescriptorWithKey:YOSEventRelationships.service
                                                                ascending:YES],
                                  [NSSortDescriptor sortDescriptorWithKey:YOSEventAttributes.name
                                                                ascending:YES],
                                  [NSSortDescriptor sortDescriptorWithKey:YOSEventAttributes.detail
                                                                ascending:NO],
                                  [NSSortDescriptor sortDescriptorWithKey:YOSEventAttributes.url
                                                                ascending:NO],
                                  [NSSortDescriptor sortDescriptorWithKey:YOSEventRelationships.user
                                                                ascending:NO]
                                  ];
    
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:reqEvents
                                                                          managedObjectContext:aContext
                                                                            sectionNameKeyPath:nil
                                                                                     cacheName:nil];
    return frc;
}


-(NSInteger) countEvents:(NSManagedObjectContext *) aContext
{
    NSFetchRequest *fr = [NSFetchRequest fetchRequestWithEntityName: [YOSEvent entityName]];
    fr.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:YOSEventAttributes.idEvent
                                                         ascending:NO]];
    
    NSError *error = nil;
    NSArray *result = [aContext executeFetchRequest:fr
                                              error:&error];
    if (!result) {
        NSLog(@"Error al buscar: %@", error);
    }
    
    return [result count];

}


-(NSInteger) countEventsForService:(YOSService *) aService
                            context:(NSManagedObjectContext *) aContext {
    
    NSFetchRequest *fr = [NSFetchRequest fetchRequestWithEntityName: [YOSEvent entityName]];
    fr.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:YOSEventAttributes.idEvent
                                                         ascending:NO]];
    
    fr.predicate = [NSPredicate predicateWithFormat:@"services == %@",aService];
    
    NSError *error = nil;
    NSArray *result = [aContext executeFetchRequest:fr
                                              error:&error];
    if (!result) {
        NSLog(@"Error al buscar: %@", error);
    }
    
    return [result count];
    
}


-(NSArray *) eventsForService:(YOSService *) aService
                       context:(NSManagedObjectContext *) aContext {
    
    NSFetchRequest *fr = [NSFetchRequest fetchRequestWithEntityName: [YOSEvent entityName]];
    fr.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:YOSEventAttributes.typeEvent
                                                         ascending:NO]];
    
    fr.predicate = [NSPredicate predicateWithFormat:@"services == %@",aService];
    
    NSError *error = nil;
    NSArray *result = [aContext executeFetchRequest:fr
                                              error:&error];
    if (result) {
        NSLog(@"Error al buscar: %@", error);
    }
    
    return result ;
    
}





@end
