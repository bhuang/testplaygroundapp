//
//  Avatar.m
//  playground
//
//  Created by Bennie Huang on 6/10/14.
//  Copyright (c) 2014 Bennie Huang. All rights reserved.
//

#import "Avatar.h"

@implementation Avatar {
    CGPoint lastTouchLocation;
}

-(void)onEnter {
    self.userInteractionEnabled=true;
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    lastTouchLocation= [touch locationInNode:self.parent];
}

- (void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    // we want to know the location of our touch in this scene
    CGPoint touchLocation = [touch locationInNode:self.parent];
    
    CGPoint delta= ccpSub(touchLocation, lastTouchLocation);
    
    //NSLog([NSString stringWithFormat:@"delta %f, %f", delta.x, delta.y]);
    
    self.position= ccpAdd(self.position, delta);
    
    lastTouchLocation=touchLocation;
}
@end
