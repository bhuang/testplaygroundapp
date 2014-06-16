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

@end
