//
//  ObjectsLayer.m
//  playground
//
//  Created by Bennie Huang on 6/10/14.
//  Copyright (c) 2014 Bennie Huang. All rights reserved.
//

#import "ObjectsLayer.h"
#import "Avatar.h"

@implementation ObjectsLayer {
    NSMutableArray *objects;
    
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
    
    CCSprite *sprite = [Avatar spriteWithImageNamed:@"Icon-Small.png"];
    
    sprite.position= ccp(50.0f, 100.0f);
    
    [objects addObject:sprite];
    
    [self addChild:sprite];
    
    return self;
}


@end
