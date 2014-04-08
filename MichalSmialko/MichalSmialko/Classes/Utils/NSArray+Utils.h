//
//  NSArray+Utils.h
//  MichalSmialko
//
//  Created by Michal Smialko on 4/7/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Utils)

- (NSArray *)arrayBySwappingObject:(id)objectA withObject:(id)objectB;

/**
 [0] -> [last]
 [1] -> [0]
 [2] -> [1]
 ...
 */
- (NSArray *)arrayByMovingObjectsForward;

@end
