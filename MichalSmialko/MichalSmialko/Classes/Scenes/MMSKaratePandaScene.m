//
//  MMSKaratePandaScene.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/6/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSKaratePandaScene.h"
#import "MMSHeroNode.h"

@interface MMSKaratePandaScene () <SKPhysicsContactDelegate>

@property (nonatomic, strong) SKNode *_world;
@property (nonatomic) CFTimeInterval _previousFrameTime;
@property (nonatomic, strong) MMSHeroNode *_heroNode;

@end

@implementation MMSKaratePandaScene

#pragma mark - UIResponder

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        
        [self._heroNode startJump];
        
//        CGPoint location = [touch locationInNode:self];
//        BOOL goRight = location.x > CGRectGetMidX(self.frame);
//        self._heroNode.dirrection = CGVectorMake(goRight ? 100 : - 100,
//                                                 self._heroNode.dirrection.dy);
    }
}

#pragma mark - SKScene

- (instancetype)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        self._previousFrameTime = -1;
        
        self._world = [SKNode node];
        [self addChild:self._world];
        
        // Bg
        SKSpriteNode *bgSprite = [SKSpriteNode spriteNodeWithImageNamed:@"bgLas"];
        bgSprite.position = CGPointMake(CGRectGetMidX(self.frame),
                                      CGRectGetMidY(self.frame));
        [self._world addChild:bgSprite];
        
        // Title
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        myLabel.text = @"Karate Panda";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       self.frame.size.height - 300);
        [self._world addChild:myLabel];
        
        // Hero
        self._heroNode = [MMSHeroNode heroNode];
        self._heroNode.position = CGPointMake(CGRectGetMidX(self.frame),
                                              CGRectGetMidY(self.frame));
        [self._world addChild:self._heroNode];
        
        // Path
        SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"lasAtlas"];
        SKTexture *texture = [atlas textureNamed:@"sciezka_kamien_zas"];
        SKSpriteNode *pathNode = [SKSpriteNode spriteNodeWithTexture:texture];
        pathNode.position = CGPointMake(300, 250);
        
        pathNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:pathNode.frame.size];
        pathNode.physicsBody.usesPreciseCollisionDetection = YES;
        pathNode.physicsBody.categoryBitMask = 0x1 << 0;
        pathNode.physicsBody.dynamic = NO;
        
        self.physicsWorld.contactDelegate = self;
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        
        [self._world addChild:pathNode];
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
    
    // Camera
    self._world.position = CGPointMake(-self._heroNode.position.x + self.frame.size.width/2.f,
                                       -self._heroNode.position.y + self.frame.size.height/2.f);
    
    self._previousFrameTime = currentTime;
}

#pragma mark - 

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    [self._heroNode stopFalling];
}

- (void)didEndContact:(SKPhysicsContact *)contact
{
    NSLog(@"end");
}

@end
