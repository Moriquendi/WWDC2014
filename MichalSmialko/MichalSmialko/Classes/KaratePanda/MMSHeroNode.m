//
//  MMSHeroNode.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/6/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSHeroNode.h"

@interface MMSHeroNode ()
@property (nonatomic) BOOL jumping;
@end

@implementation MMSHeroNode

#pragma mark - SKSpriteNode

- (instancetype)init
{
    if (self = [super init]) {
        self.jumping = NO;
    }
    return self;
}

#pragma mark - MMSHeroNode

- (void)updateLocation:(CFTimeInterval)dt
{
    self.position = CGPointMake(self.position.x + dt * self.dirrection.dx,
                                self.position.y + dt * self.dirrection.dy);
    
    if (self.jumping) {
        self.dirrection = CGVectorMake(self.dirrection.dx,
                                       MAX(self.dirrection.dy - dt * 400, -550));
    }
}

- (void)stopMoving
{
    self.dirrection = CGVectorMake(0, 0);
}

- (void)startJump
{
    self.dirrection = CGVectorMake(self.dirrection.dx,
                                   300);
    self.jumping = YES;
}

@end
