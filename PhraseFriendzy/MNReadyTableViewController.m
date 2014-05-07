//
//  MNReadyTableViewController.m
//  PhraseFriendzy
//
//  Created by James Adams on 5/5/14.
//  Copyright (c) 2014 James Adams. All rights reserved.
//

#import "MNReadyTableViewController.h"
#import "MNDataObject.h"
#import "MNStepperTableViewCell.h"

@interface MNReadyTableViewController ()

@end

@implementation MNReadyTableViewController

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
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(section == 0)
    {
        return [[[MNDataObject sharedDataObject] selectedTeamsIndexes] count];
    }
    else if(section == 1)
    {
        return 1;
    }
    else if(section == 2)
    {
        return 2;
    }
    else if(section == 3)
    {
        return 1;
    }
    
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return @"These Teams Are Playing";
    }
    else if(section == 1)
    {
        return @"This Is The Category Of Words";
    }
    else if(section == 2)
    {
        return @"Settings";
    }
    else if(section == 3)
    {
        return @"Ready?";
    }
    
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 2)
    {
        MNStepperTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StepperCell" forIndexPath:indexPath];;
        if(indexPath.row == 0)
        {
            cell.titleLabel.text = @"Score To Win";
            [cell.stepper setValue:[[MNDataObject sharedDataObject] scoreToWin]];
            [cell.stepper setMinimumValue:3];
            [cell.stepper setMaximumValue:100];
            [cell stepperValueChange:nil];
        }
        else if(indexPath.row == 1)
        {
            cell.titleLabel.text = @"Seconds Per Round";
            [cell.stepper setValue:[[MNDataObject sharedDataObject] secondsPerRound]];
            [cell.stepper setMinimumValue:5];
            [cell.stepper setMaximumValue:120];
            [cell stepperValueChange:nil];
        }
        
        return cell;
    }
    else
    {
        UITableViewCell *cell;
        if(indexPath.section == 0)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"TeamNameCell" forIndexPath:indexPath];
            cell.textLabel.text = [[[MNDataObject sharedDataObject] teamNames] objectAtIndex:[[[[MNDataObject sharedDataObject] selectedTeamsIndexes] objectAtIndex:indexPath.row] integerValue]];
        }
        else if(indexPath.section == 1)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"TeamNameCell" forIndexPath:indexPath];
            cell.textLabel.text = [[[MNDataObject sharedDataObject] category] stringByDeletingPathExtension];
        }
        else if(indexPath.section == 3)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"StartCell" forIndexPath:indexPath];
        }
        
        return cell;
    }
    
    return nil;
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"StartSegue"])
    {
        [[MNDataObject sharedDataObject] setSecondsPerRound:(int)[[(MNStepperTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:2]] stepper] value]];
        [[MNDataObject sharedDataObject] setScoreToWin:(int)[[(MNStepperTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]] stepper] value]];
    }
}

@end
