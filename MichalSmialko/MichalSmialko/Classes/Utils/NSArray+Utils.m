//
//  NSArray+Utils.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/7/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "NSArray+Utils.h"

@implementation NSArray (Utils)

- (NSArray *)arrayBySwappingObject:(id)objectA withObject:(id)objectB
{
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:self];
    NSInteger aIndex = [mutableArray indexOfObject:objectA];
    NSInteger bIndex = [mutableArray indexOfObject:objectB];
    [mutableArray removeObjectAtIndex:aIndex];
    [mutableArray insertObject:objectB atIndex:aIndex];
    
    [mutableArray removeObjectAtIndex:bIndex];
    [mutableArray insertObject:objectB atIndex:aIndex];
    
    return [NSArray arrayWithArray:mutableArray];
}

- (NSArray *)arrayByMovingObjectsForward
{
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:self];
    id lastObject = [mutableArray lastObject];
    
    [mutableArray removeObjectAtIndex:[mutableArray count] - 1]; // Remove last object
    [mutableArray insertObject:lastObject atIndex:0];
    
    return [NSArray arrayWithArray:mutableArray];
}

@end
