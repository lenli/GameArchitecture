//
//  Character.h
//  GameArchitecture
//
//  Created by Leonard Li on 6/30/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Character : CCSprite {
    BOOL _jumped;
}
- (void)jump;
- (void)resetJump;
- (void)updateVelocity;

@end
