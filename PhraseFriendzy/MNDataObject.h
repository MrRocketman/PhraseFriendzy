//
//  MNDataObject.h
//  PhraseFriendzy
//
//  Created by James Adams on 5/5/14.
//  Copyright (c) 2014 James Adams. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    kTeamPlay = 0,
    kIndividualPlay
} GameMode;

@interface MNDataObject : NSObject

+ (MNDataObject *)sharedDataObject;

@property(assign, nonatomic) GameMode gamemode;

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
