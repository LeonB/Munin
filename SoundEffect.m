//
//  SoundEffect.m
//  Munin
//
//  Created by Leon Bogaert on 07-11-10.
//  Copyright 2010 Tim_online. All rights reserved.
//

#import "SoundEffect.h"


@implementation SoundEffect

- (id) initWithContentsOfFile:(NSString *)path;
{
	self = [super init];
	if (self != nil) {
		NSURL *filePath = [NSURL fileURLWithPath: path isDirectory:NO];
		
		AudioServicesCreateSystemSoundID((CFURLRef)filePath, &soundID);
	}
	return self;
}


-(void)play { 
	
	AudioServicesPlaySystemSound(soundID); 
}

@end