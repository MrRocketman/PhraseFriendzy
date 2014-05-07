//
//  MNStepperTableViewCell.h
//  PhraseFriendzy
//
//  Created by James Adams on 5/6/14.
//  Copyright (c) 2014 James Adams. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MNStepperTableViewCell : UITableViewCell

@property(strong, nonatomic) IBOutlet UILabel *titleLabel;
@property(strong, nonatomic) IBOutlet UILabel *valueLabel;
@property(strong, nonatomic) IBOutlet UIStepper *stepper;

- (IBAction)stepperValueChange:(id)sender;

@end
