// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to YOSService.h instead.

@import CoreData;
#import "YOSGossipBaseClass.h"

extern const struct YOSServiceAttributes {
	__unsafe_unretained NSString *detail;
	__unsafe_unretained NSString *name;
} YOSServiceAttributes;

extern const struct YOSServiceRelationships {
	__unsafe_unretained NSString *event;
	__unsafe_unretained NSString *photo;
	__unsafe_unretained NSString *user;
} YOSServiceRelationships;

@class YOSEvent;
@class YOSPhotoContainer;
@class YOSUser;

@interface YOSServiceID : NSManagedObjectID {}
@end

@interface _YOSService : YOSGossipBaseClass {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) YOSServiceID* objectID;

@property (nonatomic, strong) NSString* detail;

//- (BOOL)validateDetail:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *event;

- (NSMutableSet*)eventSet;

@property (nonatomic, strong) YOSPhotoContainer *photo;

//- (BOOL)validatePhoto:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) YOSUser *user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;

@end

@interface _YOSService (EventCoreDataGeneratedAccessors)
- (void)addEvent:(NSSet*)value_;
- (void)removeEvent:(NSSet*)value_;
- (void)addEventObject:(YOSEvent*)value_;
- (void)removeEventObject:(YOSEvent*)value_;

@end

@interface _YOSService (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveDetail;
- (void)setPrimitiveDetail:(NSString*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSMutableSet*)primitiveEvent;
- (void)setPrimitiveEvent:(NSMutableSet*)value;

- (YOSPhotoContainer*)primitivePhoto;
- (void)setPrimitivePhoto:(YOSPhotoContainer*)value;

- (YOSUser*)primitiveUser;
- (void)setPrimitiveUser:(YOSUser*)value;

@end
