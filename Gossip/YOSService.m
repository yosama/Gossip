#import "YOSService.h"
#import "YOSEvent.h"
#import "YOSPhotoContainer.h"

@interface YOSService ()



@end

@implementation YOSService

+(instancetype) serviceWithName: (NSString *) aName
                         detail: (NSString * ) aDetail
                          photo: (YOSPhotoContainer *) aPhoto
                        context:(NSManagedObjectContext *) aContext {
    
    YOSService *serv = [YOSService insertInManagedObjectContext:aContext];
    
    serv.name = aName;
    serv.detail = aDetail;
    serv.photo = aPhoto;
    
    return serv;
}



+(instancetype) serviceForNameService:(NSString *) aNameService
                            context:(NSManagedObjectContext *) aContext {
    
    YOSService *service = nil;
    NSFetchRequest *fr = [NSFetchRequest fetchRequestWithEntityName:[YOSService entityName]];
    fr.fetchBatchSize = 10;
    fr.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:YOSServiceAttributes.name
                                                         ascending:NO]];
    
    fr.predicate = [NSPredicate predicateWithFormat:@"name == %@",aNameService];
    
    NSError *err = nil;
    NSArray *res = [aContext executeFetchRequest:fr
                                           error:&err] ;
    
    if (res == nil) {
        // la cagamos
        NSLog(@"Error al buscar: %@", err);
    } else {
        service =[res objectAtIndex:0];
    }
    
    return service;
    
}







@end
