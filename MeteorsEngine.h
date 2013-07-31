//
//  MeteorsEngine.h
//  BIS
//
//  Created by Paulo on 30/07/13.
//  Copyright 2013 neocite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Meteor.h"

@protocol MeteorsEngineDelegate;

@protocol MeteorsEngineDelegate <NSObject>
- (void)meteorsEngineDidCreateMeteor:(Meteor *)meteor;
@end

@interface MeteorsEngine : CCLayer
    
@property (nonatomic, assign) id<MeteorsEngineDelegate>delegate;
+ (MeteorsEngine *)meteorEngine;

-(void) increaseDifficulty;

@end



