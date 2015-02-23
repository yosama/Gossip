// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to YOSCredential.m instead.

#import "_YOSCredential.h"

const struct YOSCredentialAttributes YOSCredentialAttributes = {
	.detail = @"detail",
	.idUser = @"idUser",
	.name = @"name",
};

const struct YOSCredentialRelationships YOSCredentialRelationships = {
	.events = @"events",
	.photo = @"photo",
	.services = @"services",
};

@implementation YOSCredentialID
@end

@implementation _YOSCredential

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Credential" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Credential";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Credential" inManagedObjectContext:moc_];
}

- (YOSCredentialID*)objectID {
	return (YOSCredentialID*)[super objectID];
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

- (int32_t)idUserValue {
	NSNumber *result = [self idUser];
	return [result intValue];
}

- (void)setIdUserValue:(int32_t)value_ {
	[self setIdUser:@(value_)];
}

- (int32_t)primitiveIdUserValue {
	NSNumber *result = [self primitiveIdUser];
	return [result intValue];
}

- (void)setPrimitiveIdUserValue:(int32_t)value_ {
	[self setPrimitiveIdUser:@(value_)];
}

@dynamic name;

@dynamic events;

- (NSMutableSet*)eventsSet {
	[self willAccessValueForKey:@"events"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"events"];

	[self didAccessValueForKey:@"events"];
	return result;
}

@dynamic photo;

@dynamic services;

- (NSMutableSet*)servicesSet {
	[self willAccessValueForKey:@"services"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"services"];

	[self didAccessValueForKey:@"services"];
	return result;
}

@end

