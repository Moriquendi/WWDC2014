//
//  MMSKaratePandaView.m
//  MichalSmialko
//
//  Created by Michal Smialko on 4/6/14.
//  Copyright (c) 2014 MMS. All rights reserved.
//

#import "MMSKaratePandaView.h"
#import "MMSKaratePandaScene.h"

@implementation MMSKaratePandaView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        SKView * skView = [[SKView alloc] initWithFrame:self.bounds];
        skView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        skView.showsFPS = YES;
        skView.showsNodeCount = YES;
        [self addSubview:skView];
        
        SKScene * scene = [MMSKaratePandaScene sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        [skView presentScene:scene];
    }
    return self;
}


@end
