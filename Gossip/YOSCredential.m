#import "YOSCredential.h"
#import "YOSService.h"
#import "YOSPhotoContainer.h"
#import "Settings.h"

@interface YOSCredential ()

// Private interface goes here.

@end

@implementation YOSCredential

+(instancetype) credentialWithDictionary: (NSDictionary *) aDictionary
                                 context: (NSManagedObjectContext *) aContext;
{
    
    YOSCredential *credential = [YOSCredential insertInManagedObjectContext:aContext];
    
    NSInteger userId = [[aDictionary objectForKey:@"id"] integerValue];
    NSString *userName = [aDictionary objectForKey:@"login"];
    YOSPhotoContainer *photoCont = [YOSPhotoContainer insertInManagedObjectContext:aContext];
    photoCont.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[aDictionary objectForKey:@"avatar_url"]]]];
    NSString *detail = [aDictionary objectForKey:@"html_url"];
    
    credential.idUser = @(userId);
    credential.name = userName;
    credential.photo = photoCont;
    credential.detail = detail;
    
   [credential.servicesSet addObject:[YOSService serviceForNameService:@"GitHub"
                                                               context:aContext]];
    return credential;
}

+(instancetype) credentialForIdUser:(NSInteger) anIdUser
                            context:(NSManagedObjectContext *) aContext
{
    
    YOSCredential *credential;
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
        if ([res count] == 0 ) {
            credential = nil;
        } else {
            credential = [res objectAtIndex:0];
        }
    }
    
    return credential;
    
}




-(NSInteger) countCredentials
{
    // Count Credentials
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[YOSCredential entityName]];
    req.fetchBatchSize = 20;
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:YOSCredentialAttributes.name
                                                          ascending:YES ]];
    NSError *err;
    
    NSArray *credentials = [STACK.context executeFetchRequest:req
                                                        error:&err];
    NSInteger numCredentials = [credentials count];
    
    return numCredentials;
}







@end
