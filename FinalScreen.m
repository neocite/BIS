//
//  FinalScreen.m
//  BIS
//
//  Created by Paulo on 30/07/13.
//  Copyright 2013 neocite. All rights reserved.
//

#import "FinalScreen.h"
#import "TitleScreen.h"

@implementation FinalScreen

+ (CCScene *)scene
{
    // 'scene' is an autorelease object.
    CCScene *scene = [CCScene node];
    // 'layer' is an autorelease object.
    FinalScreen *layer = [FinalScreen node];
    // add layer as a child to scene
    [scene addChild:layer];
    // return the scene
    return scene;
}

- (id)init {
    
    self = [super init];
    if (self) {
        // Imagem de Background
        CCSprite *background = [CCSprite spriteWithFile:kBACKGROUND];
        background.position =
        ccp(SCREEN_WIDTH() / 2.0f, SCREEN_HEIGHT() / 2.0f);
        [self addChild:background];
        // Som
        [[SimpleAudioEngine sharedEngine] playEffect:@"finalend.wav"];
        // Imagem
        CCSprite *title = [CCSprite spriteWithFile:kFINALEND];
        title.position =
        ccp(SCREEN_WIDTH() / 2.0f, SCREEN_HEIGHT() - 130.0f);
        [self addChild:title];
        
        CCMenuItemSprite *beginButton = [CCMenuItemSprite
                                         itemWithNormalSprite:[CCSprite spriteWithFile:kPLAY]
                                         selectedSprite:[CCSprite spriteWithFile:kPLAY]
                                         target:self
                                         selector:@selector(restartGame:)];
        
        // Define a posição do botão
        beginButton.position = ccp(0.0f, 0.0f);
        // Cria o menu que terá o botão
        CCMenu *menu = [CCMenu menuWithItems:beginButton, nil];
        [self addChild:menu];
        
    }
    return self;
}

- (void)restartGame:(id)sender
{
    // Pausa a música de fundo
    [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
    // Transfere o Jogador para a TitleScreen
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0
                                                                                 scene:[TitleScreen scene] ]];
}


@end
