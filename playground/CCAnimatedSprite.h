//
//  CCAnimatedSprite.h
//  playground
//
//  Created by Bennie Huang on 6/17/14.
//  Copyright (c) 2014 Bennie Huang. All rights reserved.
//

#import "cocos2d.h"

@interface CCAnimatedSprite : CCSprite
+(CCAnimatedSprite *) spriteWithFrames:(int)frames;
-(CCAnimatedSprite *)initAnimatedSrpiteWithFrames:(int)frames;
-(void)runWalkAnimation;
@end
