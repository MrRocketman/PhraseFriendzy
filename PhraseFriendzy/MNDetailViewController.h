//
//  MNDetailViewController.h
//  PhraseFriendzy
//
//  Created by James Adams on 5/5/14.
//  Copyright (c) 2014 James Adams. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MNDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
