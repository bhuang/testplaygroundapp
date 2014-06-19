//
//  MapObject.h
//  playground
//
//  Created by Bennie Huang on 6/10/14.
//  Copyright (c) 2014 Bennie Huang. All rights reserved.
//

#import "CCScene.h"
#import "CCAnimatedSprite.h"

@interface MapObject : CCScene <CCAnimatedSpriteDelegate>
+(MapObject *)scene;
-(id)init;
-(CGPoint)sanitizePointForSprite:(CCSprite *)sprite atPoint:(CGPoint)point;
@end
