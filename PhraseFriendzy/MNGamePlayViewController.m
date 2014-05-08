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
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface MNGamePlayViewController ()

@property(assign, nonatomic) int currentWordIndex;
@property(strong, nonatomic) NSTimer *timer;
@property(strong, nonatomic) AVAudioPlayer *audio;

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
    
    if([[MNDataObject sharedDataObject] gameTime] == kTotalTime)
    {
        [MNDataObject sharedDataObject].timeLeft = [[MNDataObject sharedDataObject] secondsPerRound];
        
        self.chooseNewWordButton.hidden = NO;
        self.chooseNewWordButton.enabled = YES;
        self.completeButton.hidden = NO;
        self.completeButton.enabled = YES;
        
        self.nextWordButton.hidden = YES;
        self.nextWordButton.enabled = NO;
    }
    else if([[MNDataObject sharedDataObject] gameTime] == kTimePerRound)
    {
        self.chooseNewWordButton.hidden = YES;
        self.chooseNewWordButton.enabled = NO;
        self.completeButton.hidden = YES;
        self.completeButton.enabled = NO;
        
        self.nextWordButton.hidden = NO;
        self.nextWordButton.enabled = YES;
    }
    
    self.currentWordIndex = -1;
    [self reset:nil];
    [self.timer setTolerance:0.1];
    
    self.navigationItem.title = [[[MNDataObject sharedDataObject] category] stringByDeletingPathExtension];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reset:) name:@"NextRound" object:nil];
}

- (void)reset:(NSNotification *)notification
{
    [self chooseNewWord];
    
    if([[MNDataObject sharedDataObject] gameTime] == kTimePerRound)
    {
        [MNDataObject sharedDataObject].timeLeft = [[MNDataObject sharedDataObject] secondsPerRound];
    }
    self.timeLeftLabel.text = [NSString stringWithFormat:@"Time Left: %d Sec", [MNDataObject sharedDataObject].timeLeft];
    [self updateTimerLabelColor];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)playAudio
{
    int numberOfAudioFiles = 4;
    int timeDivisionPerAudioFile = [[MNDataObject sharedDataObject] secondsPerRound] / numberOfAudioFiles;
    int audioFileToPlay = [MNDataObject sharedDataObject].timeLeft / timeDivisionPerAudioFile;
    NSString *soundFilePath;
    // For 12 audio files
    /*switch (audioFileToPlay)
    {
        case 11:
            soundFilePath = [[NSBundle mainBundle] pathForResource:@"PFBeep1_30" ofType:@"m4a"];
            break;
        case 10:
            soundFilePath = [[NSBundle mainBundle] pathForResource:@"PFBeep1_60" ofType:@"m4a"];
            break;
        case 9:
            soundFilePath = [[NSBundle mainBundle] pathForResource:@"PFBeep1_90" ofType:@"m4a"];
            break;
        case 8:
            soundFilePath = [[NSBundle mainBundle] pathForResource:@"PFBeep1_120" ofType:@"m4a"];
            break;
        case 7:
            soundFilePath = [[NSBundle mainBundle] pathForResource:@"PFBeep1_150" ofType:@"m4a"];
            break;
        case 6:
            soundFilePath = [[NSBundle mainBundle] pathForResource:@"PFBeep1_180" ofType:@"m4a"];
            break;
        case 5:
            soundFilePath = [[NSBundle mainBundle] pathForResource:@"PFBeep1_210" ofType:@"m4a"];
            break;
        case 4:
            soundFilePath = [[NSBundle mainBundle] pathForResource:@"PFBeep1_240" ofType:@"m4a"];
            break;
        case 3:
            soundFilePath = [[NSBundle mainBundle] pathForResource:@"PFBeep1_270" ofType:@"m4a"];
            break;
        case 2:
            soundFilePath = [[NSBundle mainBundle] pathForResource:@"PFBeep1_300" ofType:@"m4a"];
            break;
        case 1:
            soundFilePath = [[NSBundle mainBundle] pathForResource:@"PFBeep1_330" ofType:@"m4a"];
            break;
        case 0:
            soundFilePath = [[NSBundle mainBundle] pathForResource:@"PFBeep1_360" ofType:@"m4a"];
            break;
        default:
            soundFilePath = [[NSBundle mainBundle] pathForResource:@"PFBeep1_30" ofType:@"m4a"];
            break;
    }*/
    switch (audioFileToPlay)
    {
        case 3:
            soundFilePath = [[NSBundle mainBundle] pathForResource:@"PFBeep1_30" ofType:@"m4a"];
            break;
        case 2:
            soundFilePath = [[NSBundle mainBundle] pathForResource:@"PFBeep1_60" ofType:@"m4a"];
            break;
        case 1:
            soundFilePath = [[NSBundle mainBundle] pathForResource:@"PFBeep1_120" ofType:@"m4a"];
            break;
        case 0:
            soundFilePath = [[NSBundle mainBundle] pathForResource:@"PFBeep1_240" ofType:@"m4a"];
            break;
        default:
            soundFilePath = [[NSBundle mainBundle] pathForResource:@"PFBeep1_30" ofType:@"m4a"];
            break;
    }
    
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    self.audio = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    self.audio.numberOfLoops = 0;
    [self.audio play];
}

- (void)updateTime:(NSTimer *)aTimer
{
    [MNDataObject sharedDataObject].timeLeft --;
    self.timeLeftLabel.text = [NSString stringWithFormat:@"Time Left: %d Sec", [MNDataObject sharedDataObject].timeLeft];
    
    [self playAudio];
    
    [self updateTimerLabelColor];
    
    if([MNDataObject sharedDataObject].timeLeft <= 0)
    {
        [self endRound];
    }
}

- (void)updateTimerLabelColor
{
    if([MNDataObject sharedDataObject].timeLeft > [[MNDataObject sharedDataObject] secondsPerRound] * 0.75)
    {
        self.timeLeftLabel.textColor = [UIColor greenColor];
    }
    else if([MNDataObject sharedDataObject].timeLeft > [[MNDataObject sharedDataObject] secondsPerRound] * 0.5)
    {
        self.timeLeftLabel.textColor = [UIColor blueColor];
    }
    else if([MNDataObject sharedDataObject].timeLeft > [[MNDataObject sharedDataObject] secondsPerRound] * 0.25)
    {
        self.timeLeftLabel.textColor = [UIColor orangeColor];
    }
    else if([MNDataObject sharedDataObject].timeLeft > 0)
    {
        self.timeLeftLabel.textColor = [UIColor redColor];
    }
}

- (void)chooseNewWord
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

- (void)endRound
{
    [self.audio stop];
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"PFEnd1" ofType:@"m4a"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    self.audio = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    self.audio.numberOfLoops = 0;
    [self.audio play];
    
    [self performSegueWithIdentifier:@"EndOfRoundSegue" sender:nil];
    [self.timer invalidate];
}

#pragma mark - IBActions

- (IBAction)endEarlyButtonPress:(id)sender
{
    [self endRound];
}

- (IBAction)nextWordButtonPress:(id)sender
{
    [self chooseNewWord];
}

- (IBAction)chooseNewWordButtonPress:(id)sender
{
    [self chooseNewWord];
}

- (IBAction)completeButtonPress:(id)sender
{
    [self endRound];
}

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
