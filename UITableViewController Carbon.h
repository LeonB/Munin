//
//  UITableView Carbon.h
//  Munin
//
//  Created by Leon Bogaert on 14-11-10.
//  Copyright 2010 Tim_online. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UITableViewController (Carbon)

- (void)viewDidLoad;
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;

@end
