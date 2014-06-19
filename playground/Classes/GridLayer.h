//
//  GridLayer.h
//  playground
//
//  Created by Bennie Huang on 6/10/14.
//  Copyright (c) 2014 Bennie Huang. All rights reserved.
//

#import "cocos2d.h"
#import "cocos2d-ui.h"

@interface GridLayer : CCScene

@property(nonatomic) float gridHeight;
@property(nonatomic) float gridWidth;
@property(nonatomic) float edgeSize;


+ (GridLayer *)sceneWithSize:(int)size andContentWidth:(float)width;
-(id)initWithEdgeSize:(int)size andContentWidth:(float)width;
-(CGPoint)getGridCoordinatesWithPointOnMap:(CGPoint)MapPoint;
-(BOOL)isPointInMap:(CGPoint)point;
@end
