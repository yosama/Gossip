#import "YOSCredential.h"
#import "YOSService.h"
#import "YOSPhotoContainer.h"

@interface YOSCredential ()

// Private interface goes here.

@end

@implementation YOSCredential

+(instancetype) credentialWithDictionary: (NSDictionary *) aDictionary
                                 context: (NSManagedObjectContext *) aContext; {
    
    YOSCredential *crendential = [YOSCredential insertInManagedObjectContext:aContext];
    
    NSInteger userId = [[aDictionary objectForKey:@"id"] integerValue];
    NSString *userName = [aDictionary objectForKey:@"login"];
    YOSPhotoContainer *photoCont = [YOSPhotoContainer insertInManagedObjectContext:aContext];
    photoCont.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[aDictionary objectForKey:@"avatar_url"]]]];
    NSString *detail = [aDictionary objectForKey:@"html_url"];
    
    
    
    
    crendential.idUser = @(userId);
    crendential.name = userName;
    crendential.photo = photoCont;
    crendential.detail = detail;
    
   crendential.services = [YOSService serviceForNameService:@"GitHub"
                                                    context:aContext];
    
    
    return crendential;
}



+(instancetype) credentialForIdUser:(NSInteger) anIdUser
                            context:(NSManagedObjectContext *) aContext {
    
    YOSCredential *credential = nil;
    NSFetchRequest *fr = [NSFetchRequest fetchRequestWithEntityName:[YOSCredential entityName]];
    fr.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:YOSCredentialAttributes.idUser
                                                         ascending:NO]];
    
    fr.predicate = [NSPredicate predicateWithFormat:@"idUser == %ul",anIdUser];
    NSError *err = nil;
    NSArray *res = [aContext executeFetchRequest:fr
                                           error:&err];
    if (res == nil) {
        // la cagamos
        NSLog(@"Error al buscar: %@", err);
    } else {
        credential = [res objectAtIndex:0];
    }
    
    return credential;
    
}



@end
