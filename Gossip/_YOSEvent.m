// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to YOSEvent.m instead.

#import "_YOSEvent.h"

const struct YOSEventAttributes YOSEventAttributes = {
	.date = @"date",
	.detail = @"detail",
	.name = @"name",
	.type = @"type",
	.url = @"url",
};

const struct YOSEventRelationships YOSEventRelationships = {
	.service = @"service",
	.user = @"user",
};

@implementation YOSEventID
@end

@implementation _YOSEvent

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Event";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Event" inManagedObjectContext:moc_];
}

- (YOSEventID*)objectID {
	return (YOSEventID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic date;

@dynamic detail;

@dynamic name;

@dynamic type;

@dynamic url;

@dynamic service;

@dynamic user;

@end

