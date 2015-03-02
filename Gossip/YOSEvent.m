#import "YOSEvent.h"
#import "YOSService.h"
#import "YOSPhotoContainer.h"
#import "YOSCredential.h"

@interface YOSEvent ()

@end

@implementation YOSEvent

#pragma mark - Class methods

+(instancetype) eventWithDictionary:(NSDictionary *) aDict
                            service:(YOSService *) aService
                            context:(NSManagedObjectContext *) aContext
{
    YOSEvent *event = [YOSEvent insertInManagedObjectContext:aContext];
    
    NSInteger eventId = [[aDict objectForKey:@"id"] integerValue] ;
    NSString *type = [aDict objectForKey:@"type"];
    
    NSString *url = nil;
    NSString *message = nil;
    NSString *author = nil;
    NSDate *createdDate = nil;
    
    if ([type isEqualToString:@"CreateEvent"]) {
        
        type = @"Created repository";
        NSDictionary *repo = [aDict objectForKey:@"repo"];
        message = [[[repo objectForKey:@"name"] componentsSeparatedByString:@"/"] objectAtIndex:1];
        url = [repo objectForKey:@"url"];
        
    } else {
        type = @"Push event";
        NSDictionary *payload = [aDict objectForKey:@"payload"];
        NSArray *commits = [payload objectForKey:@"commits"];
        
        NSDictionary *authorDict = nil;
        
        for (NSDictionary *dict in commits) {
            message = [dict objectForKey:@"message"];
            url = [dict objectForKey:@"url"];
            authorDict = [dict objectForKey:@"author"];
        }
        
        NSDateFormatter *df = [NSDateFormatter new];
        createdDate = [df dateFromString:[aDict objectForKey:@"created_at"]];
        author = [authorDict objectForKey:@"name"];
    }
    
    event.idEvent = @(eventId);
    event.name = message;
    event.typeEvent = type;
    event.url = url;
    event.detail = author;
    event.date = createdDate;
    event.service = aService;
    
    NSInteger idUser = [[[NSDictionary dictionaryWithDictionary:[aDict objectForKey:@"actor"] ] objectForKey:@"id"] integerValue];
    event.user = [YOSCredential credentialForIdUser:idUser context:aContext];
    
return event;
}


+(NSFetchedResultsController *) eventWithMOC: (NSManagedObjectContext *) aContext {
    
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


#pragma mark - Utils

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
