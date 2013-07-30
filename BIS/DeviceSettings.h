//
//  DeviceSettings.h
//  BIS
//
//  Created by Paulo on 30/07/13.
//  Copyright 2013 neocite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface DeviceSettings : NSObject
    
#define SCREEN_WIDTH() \
[CCDirector sharedDirector].winSize.width

#define SCREEN_HEIGHT() \
[CCDirector sharedDirector].winSize.height

#define WIN_SIZE() \
[CCDirector sharedDirector].winSize

@end
