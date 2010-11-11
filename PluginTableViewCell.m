//
//  PluginTableViewCell.m
//  Munin
//
//  Created by Leon Bogaert on 11-11-10.
//  Copyright 2010 Tim_online. All rights reserved.
//

#import "PluginTableViewCell.h"
#import "Plugin.h"

@implementation PluginTableViewCell
@synthesize plugin;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        // Initialization code
		self.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	
    [super setSelected:selected animated:animated];
	
    // Configure the view for the selected state
}

#pragma mark -
#pragma mark Recipe set accessor

- (void)setPlugin:(Plugin *)newPlugin {
	NSLog(@"setPlugin called");
    if (newPlugin != plugin) {
        [plugin release];
        plugin = [newPlugin retain];
	}
	
	self.textLabel.text = plugin.name;
}


- (void)dealloc {
	[plugin release];
    [super dealloc];
}


@end
