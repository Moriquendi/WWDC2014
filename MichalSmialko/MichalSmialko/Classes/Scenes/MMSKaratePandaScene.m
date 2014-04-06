//
//  MMSKaratePandaScene.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/6/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSKaratePandaScene.h"
#import "MMSHeroNode.h"

@interface MMSKaratePandaScene ()

@property (nonatomic) CFTimeInterval _previousFrameTime;
@property (nonatomic, strong) MMSHeroNode *_heroNode;

@end

@implementation MMSKaratePandaScene

#pragma mark - UIResponder

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        [self._heroNode startJump];
        
        BOOL goRight = location.x > CGRectGetMidX(self.frame);
        self._heroNode.dirrection = CGVectorMake(goRight ? 100 : - 100,
                                                 self._heroNode.dirrection.dy);
        
//        self._heroNode.position = location;
//        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
//        
//        [sprite runAction:[SKAction repeatActionForever:action]];
//        
//        [self addChild:sprite];
    }
}

#pragma mark - SKScene

- (instancetype)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        self._previousFrameTime = -1;
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        myLabel.text = @"Karate Panda";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        [self addChild:myLabel];
        
        
        SKSpriteNode *bgSprite = [SKSpriteNode spriteNodeWithImageNamed:@"bgLas"];
        bgSprite.position = CGPointMake(CGRectGetMidX(self.frame),
                                      CGRectGetMidY(self.frame));
        [self addChild:bgSprite];
        
        // Hero
        SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"panda"];
        SKTexture *texture = [atlas textureNamed:@"panda_stoi01"];
        self._heroNode = [MMSHeroNode spriteNodeWithTexture:texture];
        self._heroNode.position = CGPointMake(CGRectGetMidX(self.frame),
                                              CGRectGetMidY(self.frame));
        [self addChild:self._heroNode];
    }
    return self;
}

-(void)update:(CFTimeInterval)currentTime
{
    if (self._previousFrameTime < 0) {
        self._previousFrameTime = currentTime;
        return;
    }
    
    CFTimeInterval dt = currentTime - self._previousFrameTime;
    
    // Logic
    [self._heroNode updateLocation:dt];
    
    
    self._previousFrameTime = currentTime;
}



@end
