//
//  CCAnimatedSprite.m
//  playground
//
//  Created by Bennie Huang on 6/17/14.
//  Copyright (c) 2014 Bennie Huang. All rights reserved.
//

#import "CCAnimatedSprite.h"
#import "CCAnimation.h";

@implementation CCAnimatedSprite {
    CCActionRepeatForever *walkForeverAction;
}

+ (CCAnimatedSprite *) spriteWithFrames:(int)frames
{
    return [[self alloc] initAnimatedSrpiteWithFrames:frames];
}

-(CCAnimatedSprite *)initAnimatedSrpiteWithFrames:(int)frames
{
    
    self = [super init];
    if (!self) return(nil);
    
    NSMutableArray *animationFrames= [NSMutableArray array];
    for(int i=1; i<=frames; i++) {
        NSString *frameName= [NSString stringWithFormat:@"bear%d.png", i];
        [animationFrames addObject: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName]];
    }

    walkForeverAction= [CCActionRepeatForever actionWithAction:[CCActionAnimate actionWithAnimation:[CCAnimation animationWithSpriteFrames:animationFrames delay:0.1f]]];
    
    return self;
    
}

-(void)runWalkAnimation
{
    [self runAction:walkForeverAction];
}

-(void)stopWalkAnimation
{
    [self stopAction:walkForeverAction];
}
@end
