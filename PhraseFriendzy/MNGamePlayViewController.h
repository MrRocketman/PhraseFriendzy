//
//  MNGamePlayViewController.h
//  PhraseFriendzy
//
//  Created by James Adams on 5/5/14.
//  Copyright (c) 2014 James Adams. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MNGamePlayViewController : UIViewController

@property(strong, nonatomic) IBOutlet UILabel *timeLeftLabel;
@property(strong, nonatomic) IBOutlet UILabel *wordLabel;
@property(strong, nonatomic) IBOutlet UIButton *nextWordButton;
@property(strong, nonatomic) IBOutlet UIButton *endEarlyButton;

@property(strong, nonatomic) IBOutlet UIButton *chooseNewWordButton;
@property(strong, nonatomic) IBOutlet UIButton *completeButton;

- (IBAction)nextWordButtonPress:(id)sender;
- (IBAction)endEarlyButtonPress:(id)sender;

- (IBAction)chooseNewWordButtonPress:(id)sender;
- (IBAction)completeButtonPress:(id)sender;

@end
