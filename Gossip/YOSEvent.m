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
                    service:(YOSService *) aService
                       user:(YOSCredential *)aCredential
                    context:(NSManagedObjectContext *) aContext {
    
    
    
    
    
    YOSEvent *event = [YOSEvent insertInManagedObjectContext:aContext];
    event.name = aName;
    event.typeEvent = aType;
    event.url = aUrl;
    event.detail = aDeatil;
    event.date = aDate;
    event.service = aService;
    event.user = aCredential;
    
    return  event;

}


+(instancetype) initWithDictionary:(NSDictionary *) aDict  context : (NSManagedObjectContext *) aContext {
    
    
    NSInteger eventId = [[self.model objectForKey:@"id"] integerValue];
    NSDictionary *payload = [self.model objectForKey:@"payload"];
    NSDictionary *commits = [payload objectForKey:@"commits"];
    NSString *message = [commits objectForKey:@"message"];
    NSString *type = [self.model objectForKey:@"type"];
    NSDateFormatter *df = [NSDateFormatter new];
    NSDate *createDate = [df dateFromString:[self.model objectForKey:@"created_at"]];
    NSString *url = [commits objectForKey:@"url"];
    NSDictionary *authorDict = [commits objectForKey:@"author"];
    NSString *author = [authorDict objectForKey:@"name"];

    
    
    YOSEvent *event = [YOSEvent insertInManagedObjectContext:aContext];
    event.
    event.name = aName;
    event.typeEvent = aType;
    event.url = aUrl;
    event.detail = aDeatil;
    event.date = aDate;
    event.service = aService;
    event.user = aCredential;
    
    
    
    return <#expression#>
}


    







return


@end
