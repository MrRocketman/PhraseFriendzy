//
//  MNGamePlayViewController.m
//  PhraseFriendzy
//
//  Created by James Adams on 5/5/14.
//  Copyright (c) 2014 James Adams. All rights reserved.
//

#import "MNGamePlayViewController.h"
#import "MNDataObject.h"
#include <stdlib.h>

@interface MNGamePlayViewController ()

@property(assign, nonatomic) int currentWordIndex;
@property(strong, nonatomic) NSTimer *timer;
@property(assign, nonatomic) int timeLeft;

@end

@implementation MNGamePlayViewController

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
    
    self.currentWordIndex = -1;
    [self reset:nil];
    [self.timer setTolerance:0.1];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reset:) name:@"NextRound" object:nil];
}

- (void)reset:(NSNotification *)notification
{
    [self nextWordButtonPress:nil];
    
    self.timeLeft = [[MNDataObject sharedDataObject] secondsPerRound];
    self.timeLeftLabel.text = [NSString stringWithFormat:@"Time Left: %d Sec", self.timeLeft];
    self.timeLeftLabel.textColor = [UIColor greenColor];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateTime:(NSTimer *)aTimer
{
    self.timeLeft --;
    
    self.timeLeftLabel.text = [NSString stringWithFormat:@"Time Left: %d Sec", self.timeLeft];
    
    if(self.timeLeft > 45)
    {
        self.timeLeftLabel.textColor = [UIColor greenColor];
    }
    else if(self.timeLeft > 30)
    {
        self.timeLeftLabel.textColor = [UIColor blueColor];
    }
    else if(self.timeLeft > 15)
    {
        self.timeLeftLabel.textColor = [UIColor orangeColor];
    }
    else if(self.timeLeft > 0)
    {
        self.timeLeftLabel.textColor = [UIColor redColor];
    }
    else if(self.timeLeft <= 0)
    {
        [self endEarlyButtonPress:nil];
    }
}

- (IBAction)endEarlyButtonPress:(id)sender
{
    [self performSegueWithIdentifier:@"EndOfRoundSegue" sender:nil];
    [self.timer invalidate];
}

- (IBAction)nextWordButtonPress:(id)sender
{
    // Remove the old word
    if(self.currentWordIndex >= 0)
    {
        [[[MNDataObject sharedDataObject] words] removeObjectAtIndex:self.currentWordIndex];
    }
    
    // Reload the words if we have run out
    int wordsAvailable = (int)[[[MNDataObject sharedDataObject] words] count];
    if(wordsAvailable == 0)
    {
        [[MNDataObject sharedDataObject] reloadWordsForCurrentCategory];
        wordsAvailable = (int)[[[MNDataObject sharedDataObject] words] count];
    }
    
    // Choose the next word here
    int randomNumber = arc4random_uniform(wordsAvailable);
    self.currentWordIndex = randomNumber;
    
    // Update the label
    self.wordLabel.text = [[[[MNDataObject sharedDataObject] words] objectAtIndex:randomNumber] capitalizedString];
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
