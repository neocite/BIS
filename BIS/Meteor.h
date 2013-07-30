//
//  Enemy.h
//  BIS
//
//  Created by Paulo on 30/07/13.
//  Copyright 2013 neocite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@protocol MeteorDelegate;

@interface Meteor : CCSprite
    
@property (nonatomic, assign) float positionX;
@property (nonatomic, assign) float positionY;
+ (Meteor *)meteorWithImage:(NSString *)image;
- (void)start;
- (void)gotShot;
@property (nonatomic, assign) id<MeteorDelegate>delegate;
@end

@protocol MeteorDelegate <NSObject>
- (void)meteorWillBeRemoved:(Meteor *)meteor;
@end
