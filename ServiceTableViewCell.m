//
//  ServiceTableViewCell.m
//  Munin
//
//  Created by Leon Bogaert on 08-11-10.
//  Copyright 2010 Tim_online. All rights reserved.
//

#import "ServiceTableViewCell.h"
#import "Service.h"

@implementation ServiceTableViewCell
@synthesize service;

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

- (void)setService:(Service *)newService {
	NSLog(@"newService called");
    if (newService != service) {
        [service release];
        service = [newService retain];
	}
	
	self.textLabel.text = service.name;
}

- (void)dealloc {
	[service release];
    [super dealloc];
}


@end
