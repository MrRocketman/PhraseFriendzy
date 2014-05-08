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
    
    int highestScoreTeamIndex = -1;
    int highestScore = -1;
    int teamScore = 0;
    // TODO: Handles ties for kTotalTime
    for(int i = 0; i < [[[MNDataObject sharedDataObject] selectedTeamsIndexes] count]; i ++)
    {
        if([[MNDataObject sharedDataObject] gameMode] == kTeamPlay)
        {
            teamScore = (int)[[[[MNDataObject sharedDataObject] teamScores] objectAtIndex:[[[[MNDataObject sharedDataObject] selectedTeamsIndexes] objectAtIndex:i] integerValue]] integerValue];
        }
        else if([[MNDataObject sharedDataObject] gameMode] == kIndividualPlay)
        {
            teamScore = (int)[[[[MNDataObject sharedDataObject] playerScores] objectAtIndex:[[[[MNDataObject sharedDataObject] selectedTeamsIndexes] objectAtIndex:i] integerValue]] integerValue];
        }
        
        // Find the highest score
        if(teamScore > highestScore)
        {
            highestScore = teamScore;
            highestScoreTeamIndex = i;
        }
    }
    
    // Set the winning name according to the highest score
    NSString *winningName;
    if([[MNDataObject sharedDataObject] gameMode] == kTeamPlay)
    {
        winningName = [[[MNDataObject sharedDataObject] teamNames] objectAtIndex:[[[[MNDataObject sharedDataObject] selectedTeamsIndexes] objectAtIndex:highestScoreTeamIndex] integerValue]];
    }
    else if([[MNDataObject sharedDataObject] gameMode] == kIndividualPlay)
    {
        winningName = [[[MNDataObject sharedDataObject] playerNames] objectAtIndex:[[[[MNDataObject sharedDataObject] selectedTeamsIndexes] objectAtIndex:highestScoreTeamIndex] integerValue]];
    }
    self.myTextLabel.text = [NSString stringWithFormat:@"%@ Wins!!!", winningName];
    
    // Reset the scores
    for(int i = 0; i < [[[MNDataObject sharedDataObject] selectedTeamsIndexes] count]; i ++)
    {
        if([[MNDataObject sharedDataObject] gameMode] == kTeamPlay)
        {
            // Reset the team scores
            [[[MNDataObject sharedDataObject] teamScores] replaceObjectAtIndex:[[[[MNDataObject sharedDataObject] selectedTeamsIndexes] objectAtIndex:i] integerValue] withObject:@(0)];
        }
        else if([[MNDataObject sharedDataObject] gameMode] == kIndividualPlay)
        {
            // Reset the player scores
            [[[MNDataObject sharedDataObject] playerScores] replaceObjectAtIndex:[[[[MNDataObject sharedDataObject] selectedTeamsIndexes] objectAtIndex:i] integerValue] withObject:@(0)];
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
