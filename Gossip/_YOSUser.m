// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to YOSUser.m instead.

#import "_YOSUser.h"

const struct YOSUserAttributes YOSUserAttributes = {
	.name = @"name",
};

const struct YOSUserRelationships YOSUserRelationships = {
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

	return keyPaths;
}

@dynamic name;

@dynamic photo;

@dynamic service;

- (NSMutableSet*)serviceSet {
	[self willAccessValueForKey:@"service"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"service"];

	[self didAccessValueForKey:@"service"];
	return result;
}

@end

