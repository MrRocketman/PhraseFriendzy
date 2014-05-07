//
//  MNDataObject.h
//  PhraseFriendzy
//
//  Created by James Adams on 5/5/14.
//  Copyright (c) 2014 James Adams. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DEFAULT_SECONDS_PER_ROUND 60
#define DEFAULT_TOTAL_TIME 300

typedef enum
{
    kTeamPlay = 0,
    kIndividualPlay
} GameMode;

typedef enum
{
    kTimePerRound = 0,
    kTotalTime
} GameTime;

@interface MNDataObject : NSObject

+ (MNDataObject *)sharedDataObject;

@property(assign, nonatomic) GameMode gameMode;
@property(assign, nonatomic) GameTime gameTime;
@property(assign, nonatomic) int timeLeft;

@property(strong, nonatomic) NSMutableArray *teamNames;
@property(strong, nonatomic) NSMutableArray *teamScores;

@property(strong, nonatomic) NSMutableArray *playerNames;
@property(strong, nonatomic) NSMutableArray *playerScores;

@property(assign, nonatomic) int scoreToWin;
@property(assign, nonatomic) int secondsPerRound;
@property(strong, nonatomic) NSMutableArray *selectedTeamsIndexes;

@property(strong, nonatomic) NSString *category;
@property(strong, nonatomic) NSMutableArray *words;
@property(strong, nonatomic) NSArray *filePaths;
@property(strong, nonatomic) NSArray *wordCountsPerFile;

- (void)updateFilePaths;
- (void)reloadWordsForCurrentCategory;

@end
