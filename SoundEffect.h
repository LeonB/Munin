//
//  SoundEffect.h
//  Munin
//
//  Created by Leon Bogaert on 07-11-10.
//  Copyright 2010 Tim_online. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioServices.h>


@interface SoundEffect : NSObject {
	SystemSoundID soundID;
}
- (id) initWithContentsOfFile:(NSString *)path; 
-(void)play;

@end