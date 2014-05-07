//
//  MNWinnerViewController.h
//  PhraseFriendzy
//
//  Created by James Adams on 5/5/14.
//  Copyright (c) 2014 James Adams. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MNWinnerViewController : UIViewController

@property(strong, nonatomic) IBOutlet UILabel *myTextLabel;
@property(strong, nonatomic) IBOutlet UIButton *startNewGameButton;

- (IBAction)newGameButtonPress:(id)sender;

@end
