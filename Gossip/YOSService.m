#import "YOSService.h"
#import "YOSEvent.h"
#import "YOSPhotoContainer.h"
#import "Settings.h"

@interface YOSService ()

@end

@implementation YOSService

#pragma mark - Class methods

+(instancetype) serviceWithName: (NSString *) aName
                         detail: (NSString * ) aDetail
                          photo: (YOSPhotoContainer *) aPhoto
                        context:(NSManagedObjectContext *) aContext
{    
    YOSService *serv = [YOSService insertInManagedObjectContext:aContext];
    
    serv.name = aName;
    serv.detail = aDetail;
    serv.photo = aPhoto;
    
    return serv;
}

+(instancetype) serviceForNameService:(NSString *) aNameService
                            context:(NSManagedObjectContext *) aContext
{
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


+(NSFetchedResultsController *) serviceWithContext: (NSManagedObjectContext *) aContext
{
    NSFetchRequest *reqServices = [NSFetchRequest fetchRequestWithEntityName:[YOSService entityName]];
    
    reqServices.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:YOSServiceAttributes.name
                                                                  ascending:YES],
                                    [NSSortDescriptor sortDescriptorWithKey:YOSServiceAttributes.detail
                                                                  ascending:YES],
                                    [NSSortDescriptor sortDescriptorWithKey:YOSServiceRelationships.photo
                                                                  ascending:NO]
                                    ];
    
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:reqServices
                                                                          managedObjectContext:aContext
                                                                            sectionNameKeyPath:nil
                                                                                     cacheName:nil];
    return frc;
}



-(NSInteger) countServices {
    //Count Services
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[YOSService entityName]];
    req.fetchBatchSize = 20;
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:YOSServiceAttributes.name
                                                          ascending:YES ]];
    NSError *err = nil;
    NSArray *services = [STACK.context executeFetchRequest:req
                                                     error:&err];
    NSInteger numServices = [services count];
    
    return numServices;

}




@end
