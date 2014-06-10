//
//  IntroScene.h
//  playground
//
//  Created by Bennie Huang on 6/10/14.
//  Copyright Bennie Huang 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Importing cocos2d.h and cocos2d-ui.h, will import anything you need to start using cocos2d-v3
#import "cocos2d.h"
#import "cocos2d-ui.h"

// -----------------------------------------------------------------------

/**
 *  The intro scene
 *  Note, that scenes should now be based on CCScene, and not CCLayer, as previous versions
 *  Main usage for CCLayer now, is to make colored backgrounds (rectangles)
 *
 */
@interface IntroScene : CCScene

// -----------------------------------------------------------------------

+ (IntroScene *)scene;
- (id)init;

// -----------------------------------------------------------------------
@end