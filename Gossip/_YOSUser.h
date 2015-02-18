// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to YOSUser.h instead.

@import CoreData;
#import "YOSGossipBaseClass.h"

extern const struct YOSUserAttributes {
	__unsafe_unretained NSString *name;
} YOSUserAttributes;

extern const struct YOSUserRelationships {
	__unsafe_unretained NSString *photo;
	__unsafe_unretained NSString *service;
} YOSUserRelationships;

@class YOSPhotoContainer;
@class YOSService;

@interface YOSUserID : NSManagedObjectID {}
@end

@interface _YOSUser : YOSGossipBaseClass {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) YOSUserID* objectID;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) YOSPhotoContainer *photo;

//- (BOOL)validatePhoto:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *service;

- (NSMutableSet*)serviceSet;

@end

@interface _YOSUser (ServiceCoreDataGeneratedAccessors)
- (void)addService:(NSSet*)value_;
- (void)removeService:(NSSet*)value_;
- (void)addServiceObject:(YOSService*)value_;
- (void)removeServiceObject:(YOSService*)value_;

@end

@interface _YOSUser (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (YOSPhotoContainer*)primitivePhoto;
- (void)setPrimitivePhoto:(YOSPhotoContainer*)value;

- (NSMutableSet*)primitiveService;
- (void)setPrimitiveService:(NSMutableSet*)value;

@end
