//
//  Gameplay.m
//  GameArchitecture
//
//  Created by Leonard Li on 6/30/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Gameplay.h"

@implementation Gameplay {
    CCNode *_levelNode;
}

- (void)didLoadFromCCB {
    CCScene *level = [CCBReader loadAsScene:@"Level3" owner:self];
    [_levelNode addChild:level];
}


@end
