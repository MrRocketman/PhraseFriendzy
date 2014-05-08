//
//  MNEndOfRoundTableViewController.m
//  PhraseFriendzy
//
//  Created by James Adams on 5/5/14.
//  Copyright (c) 2014 James Adams. All rights reserved.
//

#import "MNEndOfRoundTableViewController.h"
#import "MNDataObject.h"
#import "MNGamePlayViewController.h"

@interface MNEndOfRoundTableViewController ()

@property(strong, nonatomic) NSIndexPath *selectedIndexPath;

@end

@implementation MNEndOfRoundTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    if([[MNDataObject sharedDataObject] gameTime] == kTotalTime)
    {
        // Check to see who won when time ran out
        if([[MNDataObject sharedDataObject] timeLeft] <= 0)
        {
            [self performSegueWithIdentifier:@"WinnerSegue" sender:nil];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(section == 0 || section == 1)
    {
        return [[[MNDataObject sharedDataObject] selectedTeamsIndexes] count];
    }
    
    if(self.selectedIndexPath != nil && section == 2)
    {
        return 1;
    }
    
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return @"Choose Who Won";
    }
    else if(section == 1)
    {
        return @"Points";
    }
    else if(self.selectedIndexPath != nil && section == 2)
    {
        return @"Ready?";
    }
    
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    // Show teams to allow user to select who won
    if(indexPath.section == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"TitleCell" forIndexPath:indexPath];
        if([[MNDataObject sharedDataObject] gameMode] == kTeamPlay)
        {
            cell.textLabel.text = [[[MNDataObject sharedDataObject] teamNames] objectAtIndex:[[[[MNDataObject sharedDataObject] selectedTeamsIndexes] objectAtIndex:indexPath.row] integerValue]];
        }
        else if([[MNDataObject sharedDataObject] gameMode] == kIndividualPlay)
        {
            cell.textLabel.text = [[[MNDataObject sharedDataObject] playerNames] objectAtIndex:[[[[MNDataObject sharedDataObject] selectedTeamsIndexes] objectAtIndex:indexPath.row] integerValue]];
        }
        
        if(self.selectedIndexPath != nil && indexPath.row == self.selectedIndexPath.row)
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    // Show team scores
    else if(indexPath.section == 1)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"RightDetailCell" forIndexPath:indexPath];
        if([[MNDataObject sharedDataObject] gameMode] == kTeamPlay)
        {
            cell.textLabel.text = [[[MNDataObject sharedDataObject] teamNames] objectAtIndex:[[[[MNDataObject sharedDataObject] selectedTeamsIndexes] objectAtIndex:indexPath.row] integerValue]];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", (int)[[[[MNDataObject sharedDataObject] teamScores] objectAtIndex:[[[[MNDataObject sharedDataObject] selectedTeamsIndexes] objectAtIndex:indexPath.row] integerValue]] integerValue]];
        }
        else if([[MNDataObject sharedDataObject] gameMode] == kIndividualPlay)
        {
            cell.textLabel.text = [[[MNDataObject sharedDataObject] playerNames] objectAtIndex:[[[[MNDataObject sharedDataObject] selectedTeamsIndexes] objectAtIndex:indexPath.row] integerValue]];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", (int)[[[[MNDataObject sharedDataObject] playerScores] objectAtIndex:[[[[MNDataObject sharedDataObject] selectedTeamsIndexes] objectAtIndex:indexPath.row] integerValue]] integerValue]];
        }
    }
    else if(indexPath.section == 2)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"NextRoundCell" forIndexPath:indexPath];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.section == 0)
    {
        // Person tapped wrong team, change the scores
        if(self.selectedIndexPath != nil)
        {
            if([[MNDataObject sharedDataObject] gameMode] == kTeamPlay)
            {
                int teamScore = (int)[[[[MNDataObject sharedDataObject] teamScores] objectAtIndex:[[[[MNDataObject sharedDataObject] selectedTeamsIndexes] objectAtIndex:self.selectedIndexPath.row] integerValue]] integerValue];
                teamScore --;
                [[[MNDataObject sharedDataObject] teamScores] replaceObjectAtIndex:[[[[MNDataObject sharedDataObject] selectedTeamsIndexes] objectAtIndex:self.selectedIndexPath.row] integerValue] withObject:@(teamScore)];
            }
            else if([[MNDataObject sharedDataObject] gameMode] == kIndividualPlay)
            {
                int teamScore = (int)[[[[MNDataObject sharedDataObject] playerScores] objectAtIndex:[[[[MNDataObject sharedDataObject] selectedTeamsIndexes] objectAtIndex:self.selectedIndexPath.row] integerValue]] integerValue];
                teamScore --;
                [[[MNDataObject sharedDataObject] playerScores] replaceObjectAtIndex:[[[[MNDataObject sharedDataObject] selectedTeamsIndexes] objectAtIndex:self.selectedIndexPath.row] integerValue] withObject:@(teamScore)];
            }
        }
        
        // Add a point to the team
        self.selectedIndexPath = indexPath;
        int teamScore = 0;
        if([[MNDataObject sharedDataObject] gameMode] == kTeamPlay)
        {
            teamScore = (int)[[[[MNDataObject sharedDataObject] teamScores] objectAtIndex:[[[[MNDataObject sharedDataObject] selectedTeamsIndexes] objectAtIndex:indexPath.row] integerValue]] integerValue];
            teamScore ++;
            [[[MNDataObject sharedDataObject] teamScores] replaceObjectAtIndex:[[[[MNDataObject sharedDataObject] selectedTeamsIndexes] objectAtIndex:indexPath.row] integerValue] withObject:@(teamScore)];
        }
        else if([[MNDataObject sharedDataObject] gameMode] == kIndividualPlay)
        {
            teamScore = (int)[[[[MNDataObject sharedDataObject] playerScores] objectAtIndex:[[[[MNDataObject sharedDataObject] selectedTeamsIndexes] objectAtIndex:indexPath.row] integerValue]] integerValue];
            teamScore ++;
            [[[MNDataObject sharedDataObject] playerScores] replaceObjectAtIndex:[[[[MNDataObject sharedDataObject] selectedTeamsIndexes] objectAtIndex:indexPath.row] integerValue] withObject:@(teamScore)];
        }
        
        if([[MNDataObject sharedDataObject] gameTime] == kTimePerRound)
        {
            // Check to see who won here
            if(teamScore >= [[MNDataObject sharedDataObject] scoreToWin])
            {
                [self performSegueWithIdentifier:@"WinnerSegue" sender:nil];
            }
        }
        
        [self.tableView reloadData];
    }
    // Next Round Button
    else if(indexPath.section == 2)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NextRound" object:nil userInfo:nil];
        [self.parentViewController dismissViewControllerAnimated:YES completion:NULL];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
