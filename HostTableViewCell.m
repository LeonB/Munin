//
//  HostTableViewCell.m
//  Munin
//
//  Created by Leon Bogaert on 04-11-10.
//  Copyright 2010 Tim_online. All rights reserved.
//

#import "HostTableViewCell.h"
#import "UACellBackgroundView.h"

@implementation HostTableViewCell
@synthesize host;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        // Initialization code
		self.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
		
		// Background Image
		self.backgroundView = [[[UACellBackgroundView alloc] initWithFrame:CGRectZero] autorelease];
		self.textLabel.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setPosition:(UACellBackgroundViewPosition)newPosition {
    [(UACellBackgroundView *)self.backgroundView setPosition:newPosition];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	
    [super setSelected:selected animated:animated];
	
    // Configure the view for the selected state
}

#pragma mark -
#pragma mark Recipe set accessor

- (void)setHost:(Host *)newHost {
	NSLog(@"setHost called");
    if (newHost != host) {
        [host release];
        host = [newHost retain];
	}
	
	self.textLabel.text = host.name;
}


- (void)dealloc {
	[host release];
    [super dealloc];
}

@end
