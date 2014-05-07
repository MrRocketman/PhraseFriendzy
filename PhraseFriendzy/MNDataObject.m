//
//  MNDataObject.m
//  PhraseFriendzy
//
//  Created by James Adams on 5/5/14.
//  Copyright (c) 2014 James Adams. All rights reserved.
//

#import "MNDataObject.h"

@interface MNDataObject()

@property(strong, nonatomic) NSString *wordsDirectory;

@end

@implementation MNDataObject

+ (MNDataObject *)sharedDataObject
{
    static MNDataObject *sharedMyModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyModel = [[self alloc] init];
    });
    
    return sharedMyModel;
}

- (id)init
{
    if(self = [super init])
    {
        self.teamNames = [[NSMutableArray alloc] initWithObjects:@"Team 1", @"Team 2", nil];
        self.teamScores = [[NSMutableArray alloc] initWithObjects:@0, @0, nil];
        
        // Finds the words directory
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        self.wordsDirectory = [NSString stringWithFormat:@"%@/words", documentsDirectory];
        
        // Finds the files names for the word files
        [self updateFilePaths];
    }
    
    return self;
}

- (void)updateFilePaths
{
    // Load in the available word files paths
    self.filePaths = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.wordsDirectory error:nil];
    
    // Update the word counts while we are at it
    NSMutableArray *wordCounts = [NSMutableArray new];
    for(int i = 0; i < self.filePaths.count; i ++)
    {
        NSString *fullFilePath = [self fullFilePathForFile:self.filePaths[i]];
        NSString *fileAsString = [[NSString alloc] initWithContentsOfFile:fullFilePath encoding:NSStringEncodingConversionAllowLossy error:nil];
        NSArray *words = [fileAsString componentsSeparatedByString:@"\n"];
        
        [wordCounts addObject:@(words.count)];
    }
    
    self.wordCountsPerFile = (NSArray *)wordCounts;
}

#pragma mark - Private Methods

- (NSString *)fullFilePathForFile:(NSString *)filePath
{
    return [NSString stringWithFormat:@"%@/%@", self.wordsDirectory, filePath];
}

@end
