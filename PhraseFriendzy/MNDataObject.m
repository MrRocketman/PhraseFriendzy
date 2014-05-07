//
//  MNDataObject.m
//  PhraseFriendzy
//
//  Created by James Adams on 5/5/14.
//  Copyright (c) 2014 James Adams. All rights reserved.
//

#import "MNDataObject.h"

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
    }
    
    return self;
}

@end
