//
//  CCAnimatedSprite.h
//  playground
//
//  Created by Bennie Huang on 6/17/14.
//  Copyright (c) 2014 Bennie Huang. All rights reserved.
//

#import "cocos2d.h"
#import "CCAnimation.h"

@class MapObject;

@protocol CCAnimatedSpriteDelegate
-(CGPoint)sanitizePointForRect:(CGRect)rect;
@end

@interface CCAnimatedSprite : CCSprite
@property (nonatomic, assign) id  delegate;

+(CCAnimatedSprite *)spriteWithFrames:(int)frames andDelegate:(MapObject *)mapObject;
-(CCAnimatedSprite *)initAnimatedSrpiteWithFrames:(int)frames andDelegate:(MapObject *)mapObject;
-(void)runWalkAnimation;
-(void)walkToPoint:(CGPoint)point;
@end
