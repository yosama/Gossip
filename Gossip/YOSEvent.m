#import "YOSEvent.h"
#import "YOSService.h"
#import "YOSPhotoContainer.h"
#import "YOSCredential.h"
#import "Settings.h"

@interface YOSEvent ()

@end

@implementation YOSEvent

#pragma mark - Class methods

+(instancetype) eventWithDictionary:(NSDictionary *) aDict
                            service:(YOSService *) aService
{
    YOSEvent *event;
    
    NSInteger eventId = [[aDict objectForKey:@"id"] integerValue] ;
    NSString *type = [aDict objectForKey:@"type"];
    
    NSString *url = nil;
    NSString *message = nil;
    NSString *author = nil;
    NSString* date;
    NSDateFormatter *df;
    NSDate *createdDate;
    NSInteger idUser;
    NSDictionary *repo;
    
    if ([type isEqualToString:@"CreateEvent"]) {
        
        repo = [aDict objectForKey:@"repo"];
        message = [[[repo objectForKey:@"name"] componentsSeparatedByString:@"/"] objectAtIndex:1];
        url = [[[[repo objectForKey:@"url"]stringByReplacingOccurrencesOfString:@"api."
                                                                     withString:@""] stringByReplacingOccurrencesOfString:@"repos/" withString:@""] stringByReplacingOccurrencesOfString:@"commits" withString:@"commit"];
        
        date = [aDict objectForKey:@"created_at"];
        date = [[date stringByReplacingOccurrencesOfString:@"T" withString:@" "] stringByReplacingOccurrencesOfString:@"Z" withString:@""] ;
        df= [NSDateFormatter new];
        df.dateFormat = @"yyyy-MM-dd''HH:mm:ss";
        createdDate = [df dateFromString:date];
        idUser = [[[NSDictionary dictionaryWithDictionary:[aDict objectForKey:@"actor"] ] objectForKey:@"id"] integerValue];
        
        event = [YOSEvent insertInManagedObjectContext:STACK.context];
        event.idEvent = @(eventId);
        event.name = message;
        event.typeEvent = type;
        event.url = url;
        event.detail = author;
        event.date = createdDate;
        event.service = aService;
        event.user = [YOSCredential credentialForIdUser:idUser context:STACK.context];
        
        
    } else {
        
        NSDictionary *payload = [aDict objectForKey:@"payload"];
        NSArray *commits = [payload objectForKey:@"commits"];
        NSDictionary *authorDict = nil;
        
        for (NSDictionary *dict in commits) {
            
            message = [dict objectForKey:@"message"];
            url = [[[[dict objectForKey:@"url"] stringByReplacingOccurrencesOfString:@"api."
                                                                          withString:@""] stringByReplacingOccurrencesOfString:@"repos/" withString:@""] stringByReplacingOccurrencesOfString:@"commits" withString:@"commit"];
            authorDict = [dict objectForKey:@"author"];
            author = [authorDict objectForKey:@"name"];
            repo = [aDict objectForKey:@"repo"];
            NSString *nameRepo = [[[repo objectForKey:@"name"] componentsSeparatedByString:@"/"] objectAtIndex:1];
            
            NSString* date = [aDict objectForKey:@"created_at"];
            date = [[date stringByReplacingOccurrencesOfString:@"T" withString:@" "] stringByReplacingOccurrencesOfString:@"Z" withString:@""] ;
            NSDateFormatter *df = [NSDateFormatter new];
            df.dateFormat = @"yyyy-MM-dd''HH:mm:ss";
            createdDate = [df dateFromString:date];
            idUser = [[[NSDictionary dictionaryWithDictionary:[aDict objectForKey:@"actor"] ] objectForKey:@"id"] integerValue];
            
            event = [YOSEvent insertInManagedObjectContext:STACK.context];
            event.name = message;
            event.idEvent = @(eventId);
            event.typeEvent = type;
            event.url = url;
            event.detail = [author stringByAppendingString:[NSString stringWithFormat:@"/%@",nameRepo]];
            event.date = createdDate;
            event.service = aService;
            event.user = [YOSCredential credentialForIdUser:idUser context:STACK.context];
        }
        
    }
    
    return event;
}

+(NSFetchedResultsController *) eventWithMOC: (NSManagedObjectContext *) aContext {
    
    NSFetchRequest *reqEvents = [NSFetchRequest fetchRequestWithEntityName:[YOSEvent entityName]];
    reqEvents.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:YOSEventAttributes.date
                                                                ascending:NO]
                                  
                                  ];
    
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:reqEvents
                                                                          managedObjectContext:aContext
                                                                            sectionNameKeyPath:nil
                                                                                     cacheName:nil];
    return frc;
}


#pragma mark - Utils

-(NSInteger) countEvents
{
    NSFetchRequest *fr = [NSFetchRequest fetchRequestWithEntityName: [YOSEvent entityName]];
    fr.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:YOSEventAttributes.idEvent
                                                         ascending:NO]];
    
    NSError *error = nil;
    NSArray *result = [STACK.context executeFetchRequest:fr
                                              error:&error];
    if (!result) {
        NSLog(@"Error al buscar: %@", error);
    }
    
    return [result count];
    
}


-(NSInteger) countEventsForService:(YOSService *) aService
{
    
    NSFetchRequest *fr = [NSFetchRequest fetchRequestWithEntityName: [YOSEvent entityName]];
    fr.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:YOSEventAttributes.idEvent
                                                         ascending:NO]];
    
    fr.predicate = [NSPredicate predicateWithFormat:@"services == %@",aService];
    
    NSError *error = nil;
    NSArray *result = [STACK.context executeFetchRequest:fr
                                              error:&error];
    if (!result) {
        NSLog(@"Error al buscar: %@", error);
    }
    
    return [result count];
    
}


-(NSArray *) eventsForService:(YOSService *) aService
{
    
    NSFetchRequest *fr = [NSFetchRequest fetchRequestWithEntityName: [YOSEvent entityName]];
    fr.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:YOSEventAttributes.typeEvent
                                                         ascending:NO]];
    
    fr.predicate = [NSPredicate predicateWithFormat:@"services == %@",aService];
    
    NSError *error = nil;
    NSArray *result = [STACK.context executeFetchRequest:fr
                                              error:&error];
    if (result) {
        NSLog(@"Error al buscar: %@", error);
    }
    
    return result ;
    
}






@end
