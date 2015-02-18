// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to YOSService.h instead.

@import CoreData;
#import "YOSGossipBaseClass.h"

extern const struct YOSServiceAttributes {
	__unsafe_unretained NSString *date;
	__unsafe_unretained NSString *detail;
	__unsafe_unretained NSString *name;
} YOSServiceAttributes;

extern const struct YOSServiceRelationships {
	__unsafe_unretained NSString *photo;
	__unsafe_unretained NSString *user;
} YOSServiceRelationships;

@class YOSPhotoContainer;
@class YOSUser;

@interface YOSServiceID : NSManagedObjectID {}
@end

@interface _YOSService : YOSGossipBaseClass {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) YOSServiceID* objectID;

@property (nonatomic, strong) NSDate* date;

//- (BOOL)validateDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* detail;

//- (BOOL)validateDetail:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) YOSPhotoContainer *photo;

//- (BOOL)validatePhoto:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *user;

- (NSMutableSet*)userSet;

@end

@interface _YOSService (UserCoreDataGeneratedAccessors)
- (void)addUser:(NSSet*)value_;
- (void)removeUser:(NSSet*)value_;
- (void)addUserObject:(YOSUser*)value_;
- (void)removeUserObject:(YOSUser*)value_;

@end

@interface _YOSService (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitiveDate;
- (void)setPrimitiveDate:(NSDate*)value;

- (NSString*)primitiveDetail;
- (void)setPrimitiveDetail:(NSString*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (YOSPhotoContainer*)primitivePhoto;
- (void)setPrimitivePhoto:(YOSPhotoContainer*)value;

- (NSMutableSet*)primitiveUser;
- (void)setPrimitiveUser:(NSMutableSet*)value;

@end
