//
//  MapObject.m
//  playground
//
//  Created by Bennie Huang on 6/10/14.
//  Copyright (c) 2014 Bennie Huang. All rights reserved.
//

#import "MapObject.h"
#import "ObjectsLayer.h"
#import "GridLayer.h"

@implementation MapObject {
    CGPoint lastTouchLocation;
    GridLayer * gridMap;
    ObjectsLayer * objects;
}

+ (MapObject *) scene
{
    return [[self alloc] init];
}

- (id) init
{
    self = [super init];
    
    if (!self) return(nil);
    self.userInteractionEnabled=true;
    
   
    [self setupBackground];
    
    gridMap= [GridLayer sceneWithSize:20 andContentWidth:self.contentSize.width];
    
    float startX= self.contentSize.width/2;
    float startY= (self.contentSize.height - (gridMap.edgeSize * gridMap.gridHeight))/2;
    
    gridMap.position= CGPointMake(startX, startY);
    
    [self addChild:gridMap z:0 name:@"gridmap"];
    
    
    objects= [ObjectsLayer scene];
    
    //[self addChild:objects z:0 name:@"objects"];
    
    
    return self;
}

-(void)setupBackground
{
    CCSprite * bg1 = [CCSprite spriteWithImageNamed:@"map_bg_02.jpg"];
    bg1.anchorPoint= CGPointMake(0, 0);
    bg1.position= CGPointMake(0, 0);
    
    CCSprite * bg2 = [CCSprite spriteWithImageNamed:@"map_bg_01.jpg"];
    bg2.anchorPoint= CGPointMake(0, 0);
    bg2.position= CGPointMake(0, bg1.contentSize.height);
    
    
    CCSprite * bg3 = [CCSprite spriteWithImageNamed:@"map_bg_03.jpg"];
    bg3.anchorPoint= CGPointMake(0, 0);
    bg3.position= CGPointMake(bg1.contentSize.width, 0);
    
    [self addChild:bg1];
    [self addChild:bg2];
    [self addChild:bg3];
    
    [self setContentSize:CGSizeMake((bg1.contentSize.width + bg3.contentSize.width), bg3.contentSize.height)];
    
    self.scaleX=.25;
    self.scaleY=.25;
    
    float startX= ((self.contentSize.width * self.scaleX) - [[CCDirector sharedDirector] viewSize].width)/2;
    float startY= ((self.contentSize.height * self.scaleY) - [[CCDirector sharedDirector] viewSize].height)/2;
    NSLog([NSString stringWithFormat:@"start position %f, %f", startX, startY]);
    
    self.position= ccpMult(CGPointMake(startX, startY), -1);
}

-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    
    CGPoint touchLocation= [touch locationInNode:self];
    CGPoint GridCoord= [gridMap getGridCoordinatesWithPointOnMap:touchLocation];
    NSLog([NSString stringWithFormat:@"GridCoord on %f, %f", GridCoord.x, GridCoord.y]);
    
    lastTouchLocation = [touch locationInNode:self.parent];
    NSLog([NSString stringWithFormat:@"lastTouchLocation on %f, %f", lastTouchLocation.x, lastTouchLocation.y]);
}



- (void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    // we want to know the location of our touch in this scene
    CGPoint touchLocation = [touch locationInNode:self.parent];
    
    CGPoint delta= ccpSub(touchLocation, lastTouchLocation);
    
    //NSLog([NSString stringWithFormat:@"delta %f, %f", delta.x, delta.y]);
    
     //NSLog([NSString stringWithFormat:@"org position %f, %f", self.position.x, self.position.y]);
    
    float tempNewLocationX=self.position.x + delta.x;
    float tempNewLocationY=self.position.y + delta.y;
    
    float minLocationX= [[CCDirector sharedDirector] viewSize].width - (self.contentSize.width * self.scaleX);
    float minLocationY= [[CCDirector sharedDirector] viewSize].height - (self.contentSize.height * self.scaleY);
    
    if(tempNewLocationX>0.0f) {
        tempNewLocationX=0.0f;
    } else if(tempNewLocationX < minLocationX) {
        tempNewLocationX= minLocationX;
    }
    
    if(tempNewLocationY>0.0f) {
        tempNewLocationY=0.0f;
    }else if(tempNewLocationY < minLocationY) {
        tempNewLocationY= minLocationY;
    }
    
    //NSLog([NSString stringWithFormat:@"new position %f, %f", self.position.x, self.position.y]);
    self.position= ccp(tempNewLocationX, tempNewLocationY);
    
    NSLog([NSString stringWithFormat:@"new position %f, %f", self.position.x, self.position.y]);
    
    lastTouchLocation=touchLocation;
    
}




@end
