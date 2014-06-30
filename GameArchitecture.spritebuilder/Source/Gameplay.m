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
    NSLog(@"Loading Gameplay");
    self.userInteractionEnabled = YES;
    CCScene *level = [CCBReader loadAsScene:@"Level1"];
    [_levelNode addChild:level];
}


@end
