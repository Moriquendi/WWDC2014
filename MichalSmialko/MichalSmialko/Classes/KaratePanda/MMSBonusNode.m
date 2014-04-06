//
//  MMSBonusNode.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/6/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSBonusNode.h"
#import "MMSKeys.h"

@implementation MMSBonusNode

#pragma mark + MMSBonusNode

+ (instancetype)bonusOfType:(NSString *)name
{
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"lasAtlas"];
    SKTexture *texture = [atlas textureNamed:@"banan_1"];
    MMSBonusNode *node = [MMSBonusNode spriteNodeWithTexture:texture];
    
    node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:node.frame.size];
    node.physicsBody.usesPreciseCollisionDetection = YES;
    node.physicsBody.categoryBitMask = bonusCategory << 0;
    node.physicsBody.dynamic = NO;
    
    return node;
}

#pragma mark - MMSBonusNode



@end
