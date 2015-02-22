// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to YOSEvent.h instead.

@import CoreData;
#import "YOSGossipBaseClass.h"

extern const struct YOSEventAttributes {
	__unsafe_unretained NSString *date;
	__unsafe_unretained NSString *detail;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *type;
	__unsafe_unretained NSString *url;
} YOSEventAttributes;

extern const struct YOSEventRelationships {
	__unsafe_unretained NSString *service;
	__unsafe_unretained NSString *user;
} YOSEventRelationships;

@class YOSService;
@class YOSUser;

@interface YOSEventID : NSManagedObjectID {}
@end

@interface _YOSEvent : YOSGossipBaseClass {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) YOSEventID* objectID;

@property (nonatomic, strong) NSDate* date;

//- (BOOL)validateDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* detail;

//- (BOOL)validateDetail:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* type;

//- (BOOL)validateType:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* url;

//- (BOOL)validateUrl:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) YOSService *service;

//- (BOOL)validateService:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) YOSUser *user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;

@end

@interface _YOSEvent (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitiveDate;
- (void)setPrimitiveDate:(NSDate*)value;

- (NSString*)primitiveDetail;
- (void)setPrimitiveDetail:(NSString*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSString*)primitiveUrl;
- (void)setPrimitiveUrl:(NSString*)value;

- (YOSService*)primitiveService;
- (void)setPrimitiveService:(YOSService*)value;

- (YOSUser*)primitiveUser;
- (void)setPrimitiveUser:(YOSUser*)value;

@end
