//
//  MainScene.m
//  GameArchitecture
//
//  Created by Leonard Li on 6/30/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "MainScene.h"

@implementation MainScene
- (void)play {
    CCScene *firstLevel = [CCBReader loadAsScene:@"Level1"];
    CCTransition *transition = [CCTransition transitionFadeWithDuration:0.8f];
    [[CCDirector sharedDirector] presentScene:firstLevel withTransition:transition];
}

@end
