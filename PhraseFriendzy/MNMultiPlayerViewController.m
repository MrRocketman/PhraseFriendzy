//
//  MNMultiPlayerViewController.m
//  PhraseFriendzy
//
//  Created by James Adams on 5/5/14.
//  Copyright (c) 2014 James Adams. All rights reserved.
//

#import "MNMultiPlayerViewController.h"
#import "MNDataObject.h"

@interface MNMultiPlayerViewController ()

@end

@implementation MNMultiPlayerViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"TeamsSegue"])
    {
        [[MNDataObject sharedDataObject] setGameMode:kTeamPlay];
        [[MNDataObject sharedDataObject] setGameTime:kTimePerRound];
    }
    else if([segue.identifier isEqualToString:@"IndividualsSegue"])
    {
        [[MNDataObject sharedDataObject] setGameMode:kIndividualPlay];
        [[MNDataObject sharedDataObject] setGameTime:kTimePerRound];
    }
    else if([segue.identifier isEqualToString:@"IndividualsTimerSegue"])
    {
        [[MNDataObject sharedDataObject] setGameMode:kIndividualPlay];
        [[MNDataObject sharedDataObject] setGameTime:kTotalTime];
    }
}

@end
