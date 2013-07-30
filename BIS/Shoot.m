//
//  Shoot.m
//  BIS
//
//  Created by Paulo on 30/07/13.
//  Copyright 2013 neocite. All rights reserved.
//

#import "Shoot.h"


@implementation Shoot


+ (Shoot *)shootWithPositionX:(float)positionX
                 andPositionY:(float)positionY
{
    Shoot *shoot = [Shoot spriteWithFile:kSHOOT];
    // Posiciona o Tiro recém criado no ponto indicado
    shoot.positionX = positionX;
    shoot.positionY = positionY;
    shoot.position = ccp(shoot.positionX, shoot.positionY);
    return shoot;
}

- (void)start
{
    // Inicia a Animação / Movimentação do Tiro
    [self scheduleUpdate];
    [[SimpleAudioEngine sharedEngine] playEffect:@"rocket-exhaust.wav"];
}

- (void)update:(float)dt
{
    // Move o Tiro para cima
    self.positionY += 2;
    self.position = ccp(self.positionX, self.positionY);
}

- (void)explode
{
    // Para o agendamento
    [self unscheduleUpdate];
    // Cria efeitos
    float dt = 0.2f;
    CCScaleBy *a1 = [CCScaleBy actionWithDuration:dt scale:2.0f];
    CCFadeOut *a2 = [CCFadeOut actionWithDuration:dt];
    CCSpawn *s1 = [CCSpawn actionWithArray:
                   [NSArray arrayWithObjects:a1, a2, nil]];
    // Método a ser executado após efeito
    CCCallFunc *c1 = [CCCallFunc actionWithTarget:self
                                         selector:@selector(removeMe:)];
    // Executa efeito
    [self runAction:[CCSequence actionWithArray:
                     [NSArray arrayWithObjects:s1, c1, nil]]];
    if ([self.delegate respondsToSelector:
         @selector(shootWillBeRemoved:)]) {
        [self.delegate shootWillBeRemoved:self];
    }
    [[SimpleAudioEngine sharedEngine] playEffect:@"explosion.mp3"];
}

- (void)removeMe:(id)sender
{
    // Quando o Tiro é removido, limpa a memória utilizada pelo mesmo
    [self removeFromParentAndCleanup:YES];
}

@end
