//
//  Gameplay.m
//  GameArchitecture
//
//  Created by Leonard Li on 6/30/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Gameplay.h"
#import "WinPopup.h"
#import "CCActionFollow+CurrentOffset.h"
#import "Character.h"

@implementation Gameplay {
    Character *_character;
    CCPhysicsNode *_physicsNode;
    BOOL _jumped;
    NSInteger _currentLevel;
    CCNode *_levelNode;
}

- (void)didLoadFromCCB {
    _physicsNode.collisionDelegate = self;
    self.userInteractionEnabled = YES;
    CCScene *level = [CCBReader loadAsScene:@"Level1"];
    [_levelNode addChild:level];
}

- (void)onEnter {
    [super onEnter];
    [_character updateVelocity];
    CCActionFollow *follow = [CCActionFollow actionWithTarget:_character worldBoundary:_physicsNode.boundingBox];
    _physicsNode.position = [follow currentOffset];
    [_physicsNode runAction:follow];
}

- (void)onEnterTransitionDidFinish {
    [super onEnterTransitionDidFinish];
    
    self.userInteractionEnabled = YES;
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    [_character jump];
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair hero:(CCNode *)hero flag:(CCNode *)flag {
    self.paused = YES;
    
    WinPopup *popup = (WinPopup *)[CCBReader load:@"WinPopup"];
    popup.positionType = CCPositionTypeNormalized;
    popup.position = ccp(0.5, 0.5);
    _currentLevel++;
    popup.nextLevelName = [NSString stringWithFormat:@"Level%d",_currentLevel];
    [self addChild:popup];
    
    return TRUE;
}

- (void)update:(CCTime)delta {
    if (CGRectGetMaxY([_character boundingBox]) <  CGRectGetMinY(_physicsNode.boundingBox)) {
        [self gameOver];
    }
}

- (void)gameOver {
    NSString *currentLevelName = [NSString stringWithFormat:@"Level%d",_currentLevel];
    CCScene *restartScene = [CCBReader loadAsScene:currentLevelName];
    CCTransition *transition = [CCTransition transitionFadeWithDuration:0.8f];
    [[CCDirector sharedDirector] presentScene:restartScene withTransition:transition];
}

@end
