//
//  Player.h
//  BIS
//
//  Created by Paulo on 30/07/13.
//  Copyright 2013 neocite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Shoot.h"

@protocol PlayerDelegate;

@interface Player : CCSprite
@property (nonatomic, assign) id<PlayerDelegate>delegate;
@property (nonatomic, assign) float positionX;
@property (nonatomic, assign) float positionY;
+ (Player *)player;
- (void)shoot;
- (void)moveLeft;
- (void)moveRight;
- (void)moveUp;
- (void)explode;
@end

@protocol PlayerDelegate <NSObject>
- (void)playerDidCreateShoot:(Shoot *)shoot;
@end


