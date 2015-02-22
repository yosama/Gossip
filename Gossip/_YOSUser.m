// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to YOSUser.m instead.

#import "_YOSUser.h"

const struct YOSUserAttributes YOSUserAttributes = {
	.detail = @"detail",
	.idUser = @"idUser",
	.name = @"name",
};

const struct YOSUserRelationships YOSUserRelationships = {
	.event = @"event",
	.photo = @"photo",
	.service = @"service",
};

@implementation YOSUserID
@end

@implementation _YOSUser

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"User";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"User" inManagedObjectContext:moc_];
}

- (YOSUserID*)objectID {
	return (YOSUserID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"idUserValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"idUser"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic detail;

@dynamic idUser;

- (int64_t)idUserValue {
	NSNumber *result = [self idUser];
	return [result longLongValue];
}

- (void)setIdUserValue:(int64_t)value_ {
	[self setIdUser:@(value_)];
}

- (int64_t)primitiveIdUserValue {
	NSNumber *result = [self primitiveIdUser];
	return [result longLongValue];
}

- (void)setPrimitiveIdUserValue:(int64_t)value_ {
	[self setPrimitiveIdUser:@(value_)];
}

@dynamic name;

@dynamic event;

- (NSMutableSet*)eventSet {
	[self willAccessValueForKey:@"event"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"event"];

	[self didAccessValueForKey:@"event"];
	return result;
}

@dynamic photo;

@dynamic service;

- (NSMutableSet*)serviceSet {
	[self willAccessValueForKey:@"service"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"service"];

	[self didAccessValueForKey:@"service"];
	return result;
}

@end

