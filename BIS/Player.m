//
//  Player.m
//  BIS
//
//  Created by Paulo on 30/07/13.
//  Copyright 2013 neocite. All rights reserved.
//

#import "Player.h"


@implementation Player

+ (Player *)player
{
    Player *player = [Player spriteWithFile:kPLAYER];
    // Posiciona o Player recém criado
    player.positionX = SCREEN_WIDTH() / 2.0f;
    player.positionY = 120.0f;
    player.position = ccp(player.positionX, player.positionY);
    return player;
}

- (void)shoot
{
    // Atira
    if ([self.delegate respondsToSelector:@selector(playerDidCreateShoot:)]) {
        [self.delegate playerDidCreateShoot:[Shoot shootWithPositionX:self.positionX
                                                         andPositionY:self.positionY]];
    }
}

-(void)explode
{
    [self unscheduleUpdate];
    // Cria efeitos
    float dt = 0.2f;
    CCScaleBy *a1 = [CCScaleBy actionWithDuration:dt scale:2.0f];
    CCFadeOut *a2 = [CCFadeOut actionWithDuration:dt];
    CCSpawn *s1 = [CCSpawn actionWithArray:[NSArray arrayWithObjects:a1, a2, nil]];
    [self runAction:s1];
    [[SimpleAudioEngine sharedEngine] playEffect:@"loud-scream.aiff"];
    [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
}

- (void)moveLeft
{
    // Move o Player para a Esquerda
    if (self.positionX > 30.0f) {
        self.positionX -= 10.0f;
    }
    self.position = ccp(self.positionX, self.positionY);
}
- (void)moveRight
{
    // Move o Player para a Direita
    if (self.positionX < SCREEN_WIDTH() - 30.0f) {
        self.positionX += 10.0f;
    }
    self.position = ccp(self.positionX, self.positionY);
}

- (void)moveUp
{
    // Move o Player para o alto
    if (self.positionY < SCREEN_HEIGHT() - 10.0f) {
        self.positionY += 20.0f;
    }
    self.position = ccp(self.positionX, self.positionY);
}
                                             
@end
