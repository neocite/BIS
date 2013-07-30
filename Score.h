//
//  Score.h
//  BIS
//
//  Created by Paulo on 30/07/13.
//  Copyright 2013 neocite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Score : CCLayer
    @property (nonatomic, assign) int score;
    @property (nonatomic, retain) CCLabelBMFont *text;
    + (Score *)score;
    - (void)increase;
@end
