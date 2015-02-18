// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to YOSService.m instead.

#import "_YOSService.h"

const struct YOSServiceAttributes YOSServiceAttributes = {
	.date = @"date",
	.detail = @"detail",
	.name = @"name",
};

const struct YOSServiceRelationships YOSServiceRelationships = {
	.photo = @"photo",
	.user = @"user",
};

@implementation YOSServiceID
@end

@implementation _YOSService

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Service" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Service";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Service" inManagedObjectContext:moc_];
}

- (YOSServiceID*)objectID {
	return (YOSServiceID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic date;

@dynamic detail;

@dynamic name;

@dynamic photo;

@dynamic user;

- (NSMutableSet*)userSet {
	[self willAccessValueForKey:@"user"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"user"];

	[self didAccessValueForKey:@"user"];
	return result;
}

@end

