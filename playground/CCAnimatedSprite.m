//
//  CCAnimatedSprite.m
//  playground
//
//  Created by Bennie Huang on 6/17/14.
//  Copyright (c) 2014 Bennie Huang. All rights reserved.
//

#import "CCAnimatedSprite.h"

@implementation CCAnimatedSprite {
    CCActionRepeatForever *walkForeverAction;
}

+ (CCAnimatedSprite *) spriteWithFrames:(int)frames andDelegate:(MapObject *)object
{
    return [[self alloc] initAnimatedSrpiteWithFrames:frames andDelegate:(MapObject *)object];
}

-(CCAnimatedSprite *)initAnimatedSrpiteWithFrames:(int)frames andDelegate:(MapObject *)object
{
    
    self = [super init];
    if (!self) return(nil);
    
    self.delegate= object;
    
    NSMutableArray *animationFrames= [NSMutableArray array];
    for(int i=1; i<=frames; i++) {
        NSString *frameName= [NSString stringWithFormat:@"bear%d.png", i];
        [animationFrames addObject: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName]];
    }
    
    [self setSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"bear1.png"]];
    
    walkForeverAction= [CCActionRepeatForever actionWithAction:[CCActionAnimate actionWithAnimation:[CCAnimation animationWithSpriteFrames:animationFrames delay:0.1f]]];
    
    return self;
    
}

/*
-(void)draw
{
    [super draw];
    float selfHeight = self.contentSize.height;
    float selfWidth = self.contentSize.width;
    CGPoint vertices[4] = {ccp(0.f, 0.f), ccp(0.f, selfHeight), ccp(selfWidth, selfHeight), ccp(selfWidth, 0.f)};
    
    
    CCDrawNode *edge = [CCDrawNode node];
    [edge drawPolyWithVerts:vertices count:4 fillColor:[CCColor colorWithRed:0 green:0 blue:0 alpha:0] borderWidth:2.0f borderColor:[CCColor redColor]];
    
    //label.position=verts[0];
    
    [self addChild:edge];
    
    
}
 */

-(void)runWalkAnimation
{
    [self runAction:walkForeverAction];
}

-(void)stopWalkAnimation
{
    [self setSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"bear1.png"]];
    [self stopAction:walkForeverAction];
}

-(void)walkToPoint:(CGPoint)point {
    
    CGSize size = CGSizeMake((self.contentSize.width * self.scale), (self.contentSize.height * self.scale));
    CGRect rect= {point, size};
    CGPoint moveToPoint= [self.delegate sanitizePointForRect:rect];
    //self.position= moveToPoint;

    float distance= ccpDistance(moveToPoint, self.position);
    //NSLog([NSString stringWithFormat:@"new %f,%f old %f,%f", point.x, point.y, self.position.x, self.position.y]);
    //NSLog([NSString stringWithFormat:@"distance %f", distance]);
    
    self.flipX= (moveToPoint.x < self.position.x) ? false : true;
    float duration = distance/150.0f;
    [self stopAllActions];
    CCActionMoveTo *moveTo = [CCActionMoveTo actionWithDuration:duration position:moveToPoint];
    CCActionCallFunc *callAfterMove = [CCActionCallFunc actionWithTarget:self selector:@selector(stopWalkAnimation)];
    [self runWalkAnimation];
    [self runAction:[CCActionSequence actionWithArray:@[moveTo, callAfterMove]]];
}

@end
