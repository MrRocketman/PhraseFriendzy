//
//  MNDataObject.h
//  PhraseFriendzy
//
//  Created by James Adams on 5/5/14.
//  Copyright (c) 2014 James Adams. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MNDataObject : NSObject

+ (MNDataObject *)sharedDataObject;

@property(strong, nonatomic) NSMutableArray *teamNames;
@property(strong, nonatomic) NSMutableArray *teamScores;
@property(strong, nonatomic) NSMutableArray *selectedTeamsIndexes;
@property(strong, nonatomic) NSString *category;
@property(strong, nonatomic) NSMutableArray *words;

@end
