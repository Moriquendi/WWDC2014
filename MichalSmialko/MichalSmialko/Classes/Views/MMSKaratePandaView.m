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
        // Self
        self.backgroundColor = [UIColor clearColor];
        self.layer.shadowColor = [[UIColor blackColor] CGColor];
        self.layer.shadowOpacity = 1.f;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowRadius = 20;
        
        // Sk
        SKView * skView = [[SKView alloc] initWithFrame:self.bounds];
        skView.layer.cornerRadius = 10.f;
        skView.clipsToBounds = YES;
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
