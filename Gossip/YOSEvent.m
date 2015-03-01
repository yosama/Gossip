#import "YOSEvent.h"
#import "YOSService.h"
#import "YOSPhotoContainer.h"
#import "YOSCredential.h"

@interface YOSEvent ()

// Private interface goes here.

@end

@implementation YOSEvent

+(instancetype) eventWithDictionary:(NSDictionary *) aDict
                            service:(YOSService *) aService
                            context:(NSManagedObjectContext *) aContext {
    
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






@end
