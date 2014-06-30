//
//  Character.m
//  GameArchitecture
//
//  Created by Leonard Li on 6/30/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Character.h"

#define CP_ALLOW_PRIVATE_ACCESS 1
#import "CCPhysics+ObjectiveChipmunk.h"

@implementation Character 

- (void)jump {
    [self.physicsBody.chipmunkObjects[0] eachArbiter:^(cpArbiter *arbiter) {
        if (!_jumped) {
            [self.physicsBody applyImpulse:ccp(0, 2000)];
            _jumped = TRUE;
            [self performSelector:@selector(resetJump) withObject:nil afterDelay:0.3f];
        }
    }];
}

- (void)resetJump {
    _jumped = FALSE;
}

- (void)updateVelocity {
    self.physicsBody.body.body->velocity_func = playerUpdateVelocity;
}

static void
playerUpdateVelocity(cpBody *body, cpVect gravity, cpFloat damping, cpFloat dt)
{
    cpAssertSoft(body->m > 0.0f && body->i > 0.0f, "Body's mass and moment must be positive to simulate. (Mass: %f Moment: %f)", body->m, body->i);
    
	body->v = cpvadd(cpvmult(body->v, damping), cpvmult(cpvadd(gravity, cpvmult(body->f, body->m_inv)), dt));
	body->w = body->w*damping + body->t*body->i_inv*dt;
    
	// Reset forces.
	body->f = cpvzero;
	body->t = 0.0f;
    
	body->v.x = 40.f;
}

@end
