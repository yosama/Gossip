// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to YOSPhotoContainer.h instead.

@import CoreData;
#import "YOSGossipBaseClass.h"

extern const struct YOSPhotoContainerAttributes {
	__unsafe_unretained NSString *photoData;
} YOSPhotoContainerAttributes;

extern const struct YOSPhotoContainerRelationships {
	__unsafe_unretained NSString *service;
	__unsafe_unretained NSString *user;
} YOSPhotoContainerRelationships;

@class YOSService;
@class YOSCredential;

@interface YOSPhotoContainerID : NSManagedObjectID {}
@end

@interface _YOSPhotoContainer : YOSGossipBaseClass {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) YOSPhotoContainerID* objectID;

@property (nonatomic, strong) NSData* photoData;

//- (BOOL)validatePhotoData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) YOSService *service;

//- (BOOL)validateService:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) YOSCredential *user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;

@end

@interface _YOSPhotoContainer (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitivePhotoData;
- (void)setPrimitivePhotoData:(NSData*)value;

- (YOSService*)primitiveService;
- (void)setPrimitiveService:(YOSService*)value;

- (YOSCredential*)primitiveUser;
- (void)setPrimitiveUser:(YOSCredential*)value;

@end
