//
//  HostDataTableViewCell.m
//  Munin
//
//  Created by Leon Bogaert on 14-11-10.
//  Copyright 2010 Tim_online. All rights reserved.
//

#import "HostDataTableViewCell.h"


@implementation HostDataTableViewCell
@synthesize hostData;

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

- (void)setHostData:(HostData *)newHostdata {
	NSLog(@"setHostData called");
    if (newHostdata != hostData) {
        [hostData release];
        hostData = [newHostdata retain];
	}
	
	//self.textLabel.text = hostData.name;
}


- (void)dealloc {
	[hostData release];
    [super dealloc];
}

@end
