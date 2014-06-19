//
//  GridLayer.m
//  playground
//
//  Created by Bennie Huang on 6/10/14.
//  Copyright (c) 2014 Bennie Huang. All rights reserved.
//

#import "GridLayer.h"


@implementation GridLayer

@synthesize gridWidth, gridHeight, edgeSize;

+ (GridLayer *)sceneWithSize:(int)size andContentWidth:(float)width
{
	return [[self alloc] initWithEdgeSize:size andContentWidth:(float)width];
}

-(id)initWithEdgeSize:(int)size andContentWidth:(float)width
{
    
    self = [super init];
    if (!self) return(nil);

    gridWidth= (width * 0.8f)/size;
    gridHeight=gridWidth/2;
    
    edgeSize= size;
    for(int x=0;x<edgeSize;x++) {
        for(int y=0;y<edgeSize;y++) {
            
            CGPoint verts[4] =
            {
                [self convertPointToIsoPointWithX:x andY:y],
                [self convertPointToIsoPointWithX:x andY:(y+1)],
                [self convertPointToIsoPointWithX:(x+1) andY:(y+1)],
                [self convertPointToIsoPointWithX:(x+1) andY:y]
            };
            
            CCDrawNode *edge = [CCDrawNode node];
            [edge drawPolyWithVerts:verts count:4 fillColor:[CCColor colorWithRed:0 green:0 blue:0 alpha:0] borderWidth:1.0f borderColor:[CCColor greenColor]];
            
            //CCLabelTTF *label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"(%d,%d)", x, y] fontName:@"Times New Roman" fontSize:(gridHeight/3.0f)];
            
            //label.position=verts[0];
            
            [self addChild:edge];
            //[self addChild:label];

            
        }
    }
    
    return self;
}

-(BOOL)isPointInMap:(CGPoint)point
{
    CGPoint gridCoords= [self getGridCoordinatesWithPointOnMap:point];
    if(gridCoords.x < 0 || gridCoords.x > (self.edgeSize-1) || gridCoords.y < 0 || gridCoords.y > (self.edgeSize-1))  {
        //NSLog([NSString stringWithFormat:@"point %f,%f at %f,%f", point.x, point.y, gridCoords.x, gridCoords.y]);
        return false;
    }
    return true;
}

-(CGPoint)convertPointToIsoPointWithX:(float)curX andY:(float)curY
{
    if(true) {
        float tempX= (curX - curY) * (gridWidth/2.0f);
        float tempY= (curX + curY) * (gridHeight/2.0f);
        return ccp(tempX, tempY);
    } else {
        float tempX= curX * gridWidth;
        float tempY= curY * gridHeight;
        return ccp(tempX, tempY);
    }
}

-(CGPoint)getGridCoordinatesWithPointOnMap:(CGPoint)MapPoint
{
    CGPoint pointOnGrid = ccpSub(MapPoint, self.position);
    //NSLog([NSString stringWithFormat:@"pointOnGrid %f, %f", pointOnGrid.x, pointOnGrid.y]);
    float TILE_HEIGHT_HALF= gridHeight/2.0f;
    float TILE_WIDTH_HALF= gridWidth/2.0f;
    int CoordX= (pointOnGrid.x / TILE_WIDTH_HALF + pointOnGrid.y / TILE_HEIGHT_HALF) /2;
    int CoordY= (pointOnGrid.y / TILE_HEIGHT_HALF -(pointOnGrid.x / TILE_WIDTH_HALF)) /2;
    return ccp(CoordX, CoordY);
    
}

@end
