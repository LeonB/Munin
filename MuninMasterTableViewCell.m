//
//  MuninMasterTableViewCell.m
//  Munin
//
//  Created by Leon Bogaert on 31-10-10.
//  Copyright 2010 Tim_online. All rights reserved.
//

#import "MuninMasterTableViewCell.h"

@implementation MuninMasterTableViewCell
@synthesize muninMaster;

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

- (void)setMuninMaster:(MuninMaster *)newMuninMaster {
	NSLog(@"setMuninMaster called");
    if (newMuninMaster != muninMaster) {
        [muninMaster release];
        muninMaster = [newMuninMaster retain];
	}

	self.textLabel.text = muninMaster.name;
}


- (void)dealloc {
	[muninMaster release];
    [super dealloc];
}


@end
