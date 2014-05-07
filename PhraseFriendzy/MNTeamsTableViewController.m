//
//  MNTeamsTableViewController.m
//  PhraseFriendzy
//
//  Created by James Adams on 5/5/14.
//  Copyright (c) 2014 James Adams. All rights reserved.
//

#import "MNTeamsTableViewController.h"
#import "MNDataObject.h"
#import "MNTeamDetailsTableViewController.h"

@interface MNTeamsTableViewController ()

@property(strong, nonatomic) NSIndexPath *selectedAccessoryIndexPath;
@property(strong, nonatomic) NSMutableArray *selectedTeams; // Array of NSIndexPaths

@end

@implementation MNTeamsTableViewController

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
    
    self.selectedTeams = [[NSMutableArray alloc] initWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], [NSIndexPath indexPathForRow:1 inSection:0], nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
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
    
    if(self.selectedTeams.count >= 2)
    {
        return 3;
    }
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(section == 0)
    {
        return [[[MNDataObject sharedDataObject] teamNames] count];
    }
    
    return 1;
}

/*- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Title";
}*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if(indexPath.section == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"TeamCell" forIndexPath:indexPath];
        
        cell.textLabel.text = [[[MNDataObject sharedDataObject] teamNames] objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
        
        for(NSIndexPath *selectedIndexPath in self.selectedTeams)
        {
            if(selectedIndexPath.row == indexPath.row)
            {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
        }
    }
    else if(indexPath.section == 1)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"NewTeamCell" forIndexPath:indexPath];
    }
    else if(indexPath.section == 2)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"NextCell" forIndexPath:indexPath];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    self.selectedAccessoryIndexPath = indexPath;
    
    [self performSegueWithIdentifier:@"TeamAccessorySegue" sender:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.section == 0)
    {
        NSIndexPath *selectedIndexPath;
        BOOL removed = NO;
        for(int i = 0; i < self.selectedTeams.count; i ++)
        {
            selectedIndexPath = self.selectedTeams[i];
            
            if(selectedIndexPath.row == indexPath.row)
            {
                [self.selectedTeams removeObjectAtIndex:i];
                removed = YES;
            }
        }
        
        if(!removed)
        {
            [self.selectedTeams addObject:indexPath];
        }
        
        [self.tableView reloadData];
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([segue.identifier isEqualToString:@"TeamAccessorySegue"])
    {
        MNTeamDetailsTableViewController *viewController = [segue destinationViewController];
        viewController.teamName = [[[MNDataObject sharedDataObject] teamNames] objectAtIndex:self.selectedAccessoryIndexPath.row];
        viewController.teamIndex = (int)self.selectedAccessoryIndexPath.row;
    }
    else if([segue.identifier isEqualToString:@"NewTeamSegue"])
    {
        MNTeamDetailsTableViewController *viewController = [segue destinationViewController];
        viewController.teamName = @"";
        viewController.teamIndex = -1;
    }
    else if([segue.identifier isEqualToString:@"NextSegue"])
    {
        NSMutableArray *selectedTeamIndexes = [NSMutableArray new];
        for(NSIndexPath *selectedIndexPath in self.selectedTeams)
        {
            [selectedTeamIndexes addObject:@(selectedIndexPath.row)];
        }
        
        [[MNDataObject sharedDataObject] setSelectedTeamsIndexes:selectedTeamIndexes];
    }
}

@end
