//
//  MMSHeroNode.h
//  MichalSmialko
//
//  Created by Michal Smialko on 4/6/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MMSHeroNode : SKSpriteNode

@property (nonatomic) BOOL running;
@property (nonatomic) CGVector dirrection;

- (void)stopMoving;
- (void)startJump;
- (void)updateLocation:(CFTimeInterval)dt;

@end
