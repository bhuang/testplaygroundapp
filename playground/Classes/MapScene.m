//
//  MapScene.m
//  playground
//
//  Created by Bennie Huang on 6/10/14.
//  Copyright (c) 2014 Bennie Huang. All rights reserved.
//

#import "MapScene.h"
#import "MapObject.h";

@implementation MapScene {
    CGPoint lastTouchLocation;
    MapObject * mapObj;
}

+ (MapScene *)scene
{
	return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    //self.userInteractionEnabled=true;
    
    mapObj=[MapObject scene];
    [self addChild:mapObj z:0 name:@"mapObj"];
    // done
	return self;
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    lastTouchLocation= [touch locationInNode:self];
    CGPoint touchOffsetPosition= ccpSub(lastTouchLocation, mapObj.position);
    
    NSLog([NSString stringWithFormat:@"touchOffsetPosition at %f, %f", touchOffsetPosition.x, touchOffsetPosition.y ]);
    float TILE_WIDTH_HALF= 26.0f/2;
    float TILE_HEIGHT_HALF= 13.0f/2;
    int tileX = (touchOffsetPosition.x / TILE_WIDTH_HALF + touchOffsetPosition.y / TILE_HEIGHT_HALF) /2;
    int tileY = (touchOffsetPosition.y / TILE_HEIGHT_HALF -(touchOffsetPosition.x / TILE_WIDTH_HALF)) /2;
    NSLog([NSString stringWithFormat:@"tile at %d, %d", tileX, tileY ]);
}

- (void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    // we want to know the location of our touch in this scene
    CGPoint touchLocation = [touch locationInNode:self];
    
    
    CGPoint delta= ccpSub(touchLocation, lastTouchLocation);
    
    NSLog([NSString stringWithFormat:@"delta %f, %f", delta.x, delta.y]);
    
    mapObj.position= ccpAdd(mapObj.position, delta);
    
    lastTouchLocation=touchLocation;
}


@end
