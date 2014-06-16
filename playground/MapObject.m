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
    float minScale;
    float maxScale;
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
    self.multipleTouchEnabled=true;
   
    [self setupBackground];
    
    gridMap= [GridLayer sceneWithSize:100 andContentWidth:self.contentSize.width];
    
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
    
    self.scale=0.25f;
    
    float startX= ((self.contentSize.width * self.scale) - [[CCDirector sharedDirector] viewSize].width)/2;
    float startY= ((self.contentSize.height * self.scale) - [[CCDirector sharedDirector] viewSize].height)/2;
    NSLog([NSString stringWithFormat:@"start position %f, %f", startX, startY]);
    
    if(self.contentSize.width > self.contentSize.height) {
        minScale= [[CCDirector sharedDirector] viewSize].height/self.contentSize.height;
    } else {
        minScale= [[CCDirector sharedDirector] viewSize].width/self.contentSize.width;
    }
    maxScale= 0.5f;
    
    self.position= ccpMult(CGPointMake(startX, startY), -1);
}

-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    if([[event allTouches] count]==1) {
        CGPoint touchLocation= [touch locationInNode:self];
        CGPoint GridCoord= [gridMap getGridCoordinatesWithPointOnMap:touchLocation];
        NSLog([NSString stringWithFormat:@"GridCoord on %f, %f", GridCoord.x, GridCoord.y]);
    }
}

-(void)setPositionForMapWithCoordX:(float)CoordX andCoordY:(float)CoordY
{
    float minLocationX= [[CCDirector sharedDirector] viewSize].width - (self.contentSize.width * self.scale);
    float minLocationY= [[CCDirector sharedDirector] viewSize].height - (self.contentSize.height * self.scale);
    
    if(CoordX>0.0f) {
        CoordX=0.0f;
    } else if(CoordX < minLocationX) {
        CoordX= minLocationX;
    }
    
    if(CoordY>0.0f) {
        CoordY=0.0f;
    }else if(CoordY < minLocationY) {
        CoordY= minLocationY;
    }

    //NSLog([NSString stringWithFormat:@"new position %f, %f", self.position.x, self.position.y]);
    self.position= ccp(CoordX, CoordY);
    
    //NSLog([NSString stringWithFormat:@"new position %f, %f", self.position.x, self.position.y]);

}

- (void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    if([[event allTouches] count]==1) {
        // we want to know the location of our touch in this scene
        CGPoint previousTouchLocation= [touch previousLocationInView:[touch view]];
        CGPoint touchLocation = [touch locationInView:[touch view]];
        
        CGPoint delta= ccpSub(touchLocation, previousTouchLocation);
        
        //NSLog([NSString stringWithFormat:@"delta %f, %f", delta.x, delta.y]);
        
        //NSLog([NSString stringWithFormat:@"org position %f, %f", self.position.x, self.position.y]);
        
        float tempNewLocationX=self.position.x + delta.x;
        float tempNewLocationY=self.position.y - delta.y;
        
        [self setPositionForMapWithCoordX:tempNewLocationX andCoordY:tempNewLocationY];
        
        //lastTouchLocation=touchLocation;
    } else if([[event allTouches] count]==2) {
        NSArray* allTouches = [[event allTouches] allObjects];
        
        UITouch* touchOne = [allTouches objectAtIndex:0];
        UITouch* touchTwo = [allTouches objectAtIndex:1];
        
        // Get the touches and previous touches.
        CGPoint touchLocationOne = [touchOne locationInView: [touchOne view]];
        CGPoint touchLocationTwo = [touchTwo locationInView: [touchTwo view]];
        
        CGPoint previousLocationOne = [touchOne previousLocationInView: [touchOne view]];
        CGPoint previousLocationTwo = [touchTwo previousLocationInView: [touchTwo view]];

        CGFloat currentDistance = sqrt(
                                       pow(touchLocationOne.x - touchLocationTwo.x, 2.0f) +
                                       pow(touchLocationOne.y - touchLocationTwo.y, 2.0f));
        
        CGFloat previousDistance = sqrt(
                                        pow(previousLocationOne.x - previousLocationTwo.x, 2.0f) +
                                        pow(previousLocationOne.y - previousLocationTwo.y, 2.0f));

        // Get the delta of the distances.
        CGFloat distanceDelta = currentDistance - previousDistance;
        
        // Next, position the camera to the middle of the pinch.
        // Get the middle position of the pinch.
        CGPoint pinchCenter = ccpMidpoint(touchLocationOne, touchLocationTwo);
        
        [self scaleMap:self.scale + (distanceDelta * 0.0005f) scaleCenter:pinchCenter];
    }
}

-(void)scaleMap:(CGFloat)newScale scaleCenter:(CGPoint) scaleCenter {
    // scaleCenter is the point to zoom to..
    // If you are doing a pinch zoom, this should be the center of your pinch.
    
    if(newScale > maxScale || newScale < minScale) {
        return;
    }
    
    // Get the original center point.
    CGPoint oldCenterPoint = ccp(scaleCenter.x * self.scale, scaleCenter.y * self.scale);
    //NSLog(@"old scale %f new scale %f", self.scale, newScale);
    // Set the scale.
    self.scale = newScale;
    
    // Get the new center point.
    CGPoint newCenterPoint = ccp(scaleCenter.x * self.scale, scaleCenter.y * self.scale);
    
    // Then calculate the delta.
    CGPoint centerPointDelta  = ccpSub(oldCenterPoint, newCenterPoint);
    
    float tempNewLocationX= self.position.x + centerPointDelta.x;
    float tempNewLocationY= self.position.y + centerPointDelta.y;
    
    [self setPositionForMapWithCoordX:tempNewLocationX andCoordY:tempNewLocationY];
}

@end
