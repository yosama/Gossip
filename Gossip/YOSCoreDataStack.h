//
//  AGTCoreDataStack.h
//
//  Created by Fernando Rodríguez Romero on 1/24/13.
//  Copyright (c) 2013 Agbo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NSManagedObjectContext;

@interface YOSCoreDataStack : NSObject

@property (strong, nonatomic, readonly) NSManagedObjectContext *context;

+(NSString *) persistentStoreCoordinatorErrorNotificationName;

+(YOSCoreDataStack *) coreDataStackWithModelName:(NSString *)aModelName
                               databaseFilename:(NSString*) aDBName;

+(YOSCoreDataStack *) coreDataStackWithModelName:(NSString *)aModelName;

+(YOSCoreDataStack *) coreDataStackWithModelName:(NSString *)aModelName
                                    databaseURL:(NSURL*) aDBURL;

-(id) initWithModelName:(NSString *)aModelName
            databaseURL:(NSURL*) aDBURL;

-(void) zapAllData;

-(void) saveWithErrorBlock: (void(^)(NSError *error))errorBlock;

@end
