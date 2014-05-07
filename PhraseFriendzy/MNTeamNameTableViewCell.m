//
//  MNTeamNameTableViewCell.m
//  PhraseFriendzy
//
//  Created by James Adams on 5/6/14.
//  Copyright (c) 2014 James Adams. All rights reserved.
//

#import "MNTeamNameTableViewCell.h"

@implementation MNTeamNameTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    
    [self.textField becomeFirstResponder];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - UITextFieldDelegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{   
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TeamNameEditingEnd" object:nil userInfo:@{@"text" : textField.text}];
    
    return NO;
}

@end
