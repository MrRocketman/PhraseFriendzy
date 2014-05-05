//
//  MNMasterViewController.h
//  PhraseFriendzy
//
//  Created by James Adams on 5/5/14.
//  Copyright (c) 2014 James Adams. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MNDetailViewController;

@interface MNMasterViewController : UITableViewController

@property (strong, nonatomic) MNDetailViewController *detailViewController;

@end
