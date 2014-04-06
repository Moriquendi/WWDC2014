//
//  MMSPath.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/6/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSPath.h"
#import "MMSKeys.h"

@implementation MMSPath

#pragma mark + MMSPath

+ (instancetype)path
{
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"lasAtlas"];
    SKTexture *texture = [atlas textureNamed:@"sciezka_kamien_zas"];
    MMSPath *node = [MMSPath spriteNodeWithTexture:texture];
    
    node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:node.frame.size];
    node.physicsBody.usesPreciseCollisionDetection = YES;
    node.physicsBody.categoryBitMask = pathCategory;
    node.physicsBody.dynamic = NO;
    
    return node;
}

#pragma mark - MMSBonusNode



@end
