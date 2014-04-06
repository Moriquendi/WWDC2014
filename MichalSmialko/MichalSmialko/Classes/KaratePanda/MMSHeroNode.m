//
//  MMSHeroNode.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/6/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSHeroNode.h"

@interface MMSHeroNode ()
@property (nonatomic, strong) SKTextureAtlas *_atlas;
@property (nonatomic, strong) NSArray *_stayAnimTextures;
@property (nonatomic, strong) NSArray *_runAnimTextures;
@property (nonatomic) BOOL jumping;
@end

@implementation MMSHeroNode

#pragma mark - SKSpriteNode

+ (instancetype)heroNode
{
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"panda"];
    SKTexture *texture = [atlas textureNamed:@"panda_stoi01"];
    MMSHeroNode *node = [MMSHeroNode spriteNodeWithTexture:texture];
    node._atlas = atlas;
    
    
    [node _loadStayAnimation];
    [node _loadRunAnimation];
    
    [node _runRunningAnimation];
    
    return node;
}

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

    if (self.dirrection.dx > 0) {
        self.xScale = 1;
    }
    else if (self.dirrection.dx < 0) {
        self.xScale = -1;
    }
    
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

#pragma mark - MMSHeroNode ()

- (void)_loadStayAnimation
{
    self._stayAnimTextures = [self _animationFrames:@"panda_stoi" count:7 reverse:YES];
}

- (void)_loadRunAnimation
{
    self._runAnimTextures = [self _animationFrames:@"panda_bieg" count:16 reverse:NO];
}

- (NSArray *)_animationFrames:(NSString *)frameName count:(NSInteger)framesCount reverse:(BOOL)isReversed
{
    NSMutableArray *textures = [NSMutableArray array];
    NSString *textureName;
    SKTexture *animFrame;
    for (int i=1; i <= framesCount; i++) {
        textureName = [NSString stringWithFormat:@"%@%d", frameName, i];
        animFrame = [self._atlas textureNamed:textureName];
        [textures addObject:animFrame];
    }
    if (isReversed) {
        for (int i=framesCount; i >= 1; i--) {
            textureName = [NSString stringWithFormat:@"%@%d", frameName, i];
            animFrame = [self._atlas textureNamed:textureName];
            [textures addObject:animFrame];
        }
    }
    return [NSArray arrayWithArray:textures];
}

- (void)_runStayAnimation
{
    [self runAction:[SKAction repeatActionForever:
                     [SKAction animateWithTextures:self._stayAnimTextures
                                      timePerFrame:0.14f
                                            resize:NO
                                           restore:YES]] withKey:@"stay"];
}

- (void)_runRunningAnimation
{
    [self runAction:[SKAction repeatActionForever:
                     [SKAction animateWithTextures:self._runAnimTextures
                                      timePerFrame:0.05f
                                            resize:NO
                                           restore:YES]] withKey:@"run"];
}

@end
