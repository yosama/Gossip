// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to YOSCredential.h instead.

@import CoreData;
#import "YOSGossipBaseClass.h"

extern const struct YOSCredentialAttributes {
	__unsafe_unretained NSString *detail;
	__unsafe_unretained NSString *idUser;
	__unsafe_unretained NSString *name;
} YOSCredentialAttributes;

extern const struct YOSCredentialRelationships {
	__unsafe_unretained NSString *events;
	__unsafe_unretained NSString *photo;
	__unsafe_unretained NSString *services;
} YOSCredentialRelationships;

@class YOSEvent;
@class YOSPhotoContainer;
@class YOSService;

@interface YOSCredentialID : NSManagedObjectID {}
@end

@interface _YOSCredential : YOSGossipBaseClass {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) YOSCredentialID* objectID;

@property (nonatomic, strong) NSString* detail;

//- (BOOL)validateDetail:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* idUser;

@property (atomic) int32_t idUserValue;
- (int32_t)idUserValue;
- (void)setIdUserValue:(int32_t)value_;

//- (BOOL)validateIdUser:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *events;

- (NSMutableSet*)eventsSet;

@property (nonatomic, strong) YOSPhotoContainer *photo;

//- (BOOL)validatePhoto:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *services;

- (NSMutableSet*)servicesSet;

@end

@interface _YOSCredential (EventsCoreDataGeneratedAccessors)
- (void)addEvents:(NSSet*)value_;
- (void)removeEvents:(NSSet*)value_;
- (void)addEventsObject:(YOSEvent*)value_;
- (void)removeEventsObject:(YOSEvent*)value_;

@end

@interface _YOSCredential (ServicesCoreDataGeneratedAccessors)
- (void)addServices:(NSSet*)value_;
- (void)removeServices:(NSSet*)value_;
- (void)addServicesObject:(YOSService*)value_;
- (void)removeServicesObject:(YOSService*)value_;

@end

@interface _YOSCredential (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveDetail;
- (void)setPrimitiveDetail:(NSString*)value;

- (NSNumber*)primitiveIdUser;
- (void)setPrimitiveIdUser:(NSNumber*)value;

- (int32_t)primitiveIdUserValue;
- (void)setPrimitiveIdUserValue:(int32_t)value_;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSMutableSet*)primitiveEvents;
- (void)setPrimitiveEvents:(NSMutableSet*)value;

- (YOSPhotoContainer*)primitivePhoto;
- (void)setPrimitivePhoto:(YOSPhotoContainer*)value;

- (NSMutableSet*)primitiveServices;
- (void)setPrimitiveServices:(NSMutableSet*)value;

@end
