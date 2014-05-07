//
//  MNTeamNameTableViewCell.h
//  PhraseFriendzy
//
//  Created by James Adams on 5/6/14.
//  Copyright (c) 2014 James Adams. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MNTeamNameTableViewCell : UITableViewCell <UITextFieldDelegate>

@property(strong, nonatomic) IBOutlet UITextField *textField;

@end
