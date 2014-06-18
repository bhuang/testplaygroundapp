//
//  ObjectsLayer.m
//  playground
//
//  Created by Bennie Huang on 6/10/14.
//  Copyright (c) 2014 Bennie Huang. All rights reserved.
//

#import "ObjectsLayer.h"

@implementation ObjectsLayer {
    NSMutableArray *objects;
    CCAnimatedSprite *bear;
}

+ (ObjectsLayer *)scene
{
	return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    
    objects= [NSMutableArray array];
    
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"AnimBear.plist"];
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"AnimBear.png"];
    
    [self addChild:spriteSheet];
    
    bear= [CCAnimatedSprite spriteWithFrames:8];
    
    [bear runWalkAnimation];
    
    [self addChild:bear];
    
    
    return self;
}


@end
