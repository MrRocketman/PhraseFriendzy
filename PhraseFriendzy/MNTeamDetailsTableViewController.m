//
//  MNTeamDetailsTableViewController.m
//  PhraseFriendzy
//
//  Created by James Adams on 5/5/14.
//  Copyright (c) 2014 James Adams. All rights reserved.
//

#import "MNTeamDetailsTableViewController.h"
#import "MNDataObject.h"
#import "MNTeamNameTableViewCell.h"

@interface MNTeamDetailsTableViewController ()

@property(assign, nonatomic) BOOL poppingViewController;

@end

@implementation MNTeamDetailsTableViewController

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(teamNameEditingEnd:) name:@"TeamNameEditingEnd" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if(!self.poppingViewController)
    {
        NSString *teamName = [[(MNTeamNameTableViewCell *)([self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]) textField] text];
        
        [self updateTeamName:teamName];
    }
}

- (void)teamNameEditingEnd:(NSNotification *)notification
{
    NSString *teamName = notification.userInfo[@"text"];
    
    [self updateTeamName:teamName];
    
    self.poppingViewController = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateTeamName:(NSString *)teamName
{
    if(self.teamIndex >= 0)
    {
        if([[MNDataObject sharedDataObject] gamemode] == kTeamPlay)
        {
            [[[MNDataObject sharedDataObject] teamNames] replaceObjectAtIndex:self.teamIndex withObject:teamName];
        }
        else if([[MNDataObject sharedDataObject] gamemode] == kIndividualPlay)
        {
            [[[MNDataObject sharedDataObject] playerNames] replaceObjectAtIndex:self.teamIndex withObject:teamName];
        }
    }
    else
    {
        if([[MNDataObject sharedDataObject] gamemode] == kTeamPlay)
        {
            [[[MNDataObject sharedDataObject] teamNames] addObject:teamName];
            [[[MNDataObject sharedDataObject] teamScores] addObject:@0];
        }
        else if([[MNDataObject sharedDataObject] gamemode] == kIndividualPlay)
        {
            [[[MNDataObject sharedDataObject] playerNames] addObject:teamName];
            [[[MNDataObject sharedDataObject] playerScores] addObject:@0];
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MNTeamNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TeamName" forIndexPath:indexPath];
    cell.textField.text = self.teamName;
    
    return cell;
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

/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
