//
//  MNStepperTableViewCell.m
//  PhraseFriendzy
//
//  Created by James Adams on 5/6/14.
//  Copyright (c) 2014 James Adams. All rights reserved.
//

#import "MNStepperTableViewCell.h"

@implementation MNStepperTableViewCell

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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)stepperValueChange:(id)sender
{
    self.valueLabel.text = [NSString stringWithFormat:@"%d", (int)self.stepper.value];
}

@end
