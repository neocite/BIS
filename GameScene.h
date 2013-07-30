//
//  GameScene.h
//  BIS
//
//  Created by Paulo on 30/07/13.
//  Copyright 2013 neocite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MeteorsEngine.h"
#import "Player.h"
#import "GameScene.h"
#import "CCMenuItemGameButton.h"
#import "Score.h"
#import "FinalScreen.h"
#import "GameOver.h"

@interface GameScene : CCLayer<MeteorsEngineDelegate,
                                PlayerDelegate,
                                MeteorDelegate,
                                ShootDelegate>

+ (CCScene *)scene;

// Engines
@property (nonatomic, retain) MeteorsEngine *meteorsEngine;
// Arrays
@property (nonatomic, retain) NSMutableArray *meteorsArray;

@property (nonatomic, retain) CCLayer *meteorsLayer;

@property (nonatomic, retain) CCLayer *playerLayer;

@property (nonatomic, retain) Player *player;

@property (nonatomic, retain) CCLayer *gameButtonsLayer;

@property (nonatomic, retain) CCLayer *shootsLayer;

@property (nonatomic, retain) NSMutableArray *shootsArray;

@property (nonatomic, retain) NSMutableArray *playersArray;

@property (nonatomic, retain) CCLayer *scoreLayer;

@property (nonatomic, retain) Score *score;

@end

