//
//  Level.m
//  GameArchitecture
//
//  Created by Leonard Li on 6/30/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Level.h"
#import "WinPopup.h"
#import "CCActionFollow+CurrentOffset.h"
#import "Character.h"

@implementation Level {
    Character *_character;
    CCPhysicsNode *_physicsNode;
    NSString *_currentLevel;
    NSString *_nextLevel;
}


- (void)didLoadFromCCB {
    _physicsNode.collisionDelegate = self;
    NSLog(@"Current Level: %@ -- Next Level: %@", _currentLevel, _nextLevel);
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
    popup.nextLevelName = _nextLevel;
    [self addChild:popup];
    
    return TRUE;
}

- (void)update:(CCTime)delta {
    if (CGRectGetMaxY([_character boundingBox]) <  CGRectGetMinY(_physicsNode.boundingBox)) {
        [self gameOver];
    }
}

- (void)gameOver {
    NSString *currentLevelName = _currentLevel;
    CCScene *restartScene = [CCBReader loadAsScene:currentLevelName];
    CCTransition *transition = [CCTransition transitionFadeWithDuration:0.8f];
    [[CCDirector sharedDirector] presentScene:restartScene withTransition:transition];
}

@end
