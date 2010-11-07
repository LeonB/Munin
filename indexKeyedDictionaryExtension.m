//
//  indexKeyedDictionaryExtension.m
//  Munin
//
//  Created by Leon Bogaert on 06-11-10.
//  Copyright 2010 Tim_online. All rights reserved.
//

@implementation NSArray (indexKeyedDictionaryExtension)

- (NSDictionary *)indexKeyedDictionary
{
	NSUInteger arrayCount = [self count];
	id arrayObjects[arrayCount], objectKeys[arrayCount];
	
	[self getObjects:arrayObjects range:NSMakeRange(0UL, arrayCount)];
	for(NSUInteger index = 0UL; index < arrayCount; index++) { objectKeys[index] = [NSNumber numberWithUnsignedInteger:index]; }
	
	return([NSDictionary dictionaryWithObjects:arrayObjects forKeys:objectKeys count:arrayCount]);
}

@end