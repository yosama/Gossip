// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to YOSEvent.m instead.

#import "_YOSEvent.h"

const struct YOSEventAttributes YOSEventAttributes = {
	.date = @"date",
	.detail = @"detail",
	.idEvent = @"idEvent",
	.name = @"name",
	.typeEvent = @"typeEvent",
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

	if ([key isEqualToString:@"idEventValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"idEvent"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic date;

@dynamic detail;

@dynamic idEvent;

- (int32_t)idEventValue {
	NSNumber *result = [self idEvent];
	return [result intValue];
}

- (void)setIdEventValue:(int32_t)value_ {
	[self setIdEvent:@(value_)];
}

- (int32_t)primitiveIdEventValue {
	NSNumber *result = [self primitiveIdEvent];
	return [result intValue];
}

- (void)setPrimitiveIdEventValue:(int32_t)value_ {
	[self setPrimitiveIdEvent:@(value_)];
}

@dynamic name;

@dynamic typeEvent;

@dynamic url;

@dynamic service;

@dynamic user;

@end

