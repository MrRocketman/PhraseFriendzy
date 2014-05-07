//
//  MNWinnerViewController.m
//  PhraseFriendzy
//
//  Created by James Adams on 5/5/14.
//  Copyright (c) 2014 James Adams. All rights reserved.
//

#import "MNWinnerViewController.h"
#import "MNDataObject.h"

@interface MNWinnerViewController ()

@end

@implementation MNWinnerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    for(int i = 0; i < [[[MNDataObject sharedDataObject] selectedTeamsIndexes] count]; i ++)
    {
        int teamScore = (int)[[[[MNDataObject sharedDataObject] teamScores] objectAtIndex:[[[[MNDataObject sharedDataObject] selectedTeamsIndexes] objectAtIndex:i] integerValue]] integerValue];
        
        if(teamScore >= [[MNDataObject sharedDataObject] scoreToWin])
        {
            NSString *winningName = [[[MNDataObject sharedDataObject] teamNames] objectAtIndex:[[[[MNDataObject sharedDataObject] selectedTeamsIndexes] objectAtIndex:i] integerValue]];
            self.myTextLabel.text = [NSString stringWithFormat:@"%@ Wins!!!", winningName];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)newGameButtonPress:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NewGame" object:nil userInfo:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
