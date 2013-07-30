//
//  Shoot.h
//  BIS
//
//  Created by Paulo on 30/07/13.
//  Copyright 2013 neocite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@protocol ShootDelegate;
@interface Shoot : CCSprite
@property (nonatomic, assign) id<ShootDelegate>delegate;
@property (nonatomic, assign) float positionX;
@property (nonatomic, assign) float positionY;

+ (Shoot *)shootWithPositionX:(float)positionX
                 andPositionY:(float)positionY;
- (void)start;
- (void)explode;

@end
@protocol ShootDelegate <NSObject>
- (void)shootWillBeRemoved:(Shoot *)shoot;
@end