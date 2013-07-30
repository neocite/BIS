//
//  Enemy.m
//  BIS
//
//  Created by Paulo on 30/07/13.
//  Copyright 2013 neocite. All rights reserved.
//

#import "Meteor.h"


@implementation Meteor


+ (Meteor *)meteorWithImage:(NSString *)image
{
    Meteor *meteor = [Meteor spriteWithFile:image];
    meteor.positionX = arc4random_uniform(SCREEN_WIDTH());
    meteor.positionY = SCREEN_HEIGHT();
    meteor.position = ccp(meteor.positionX, meteor.positionY);
    return meteor;
}

- (void)start
{
    [self scheduleUpdate];
}

- (void)update:(float)dt
{
    self.positionY -= 1;
    self.position = ccp(self.positionX, self.positionY);
}

- (void)gotShot
{
    // Para o agendamento
    [self unscheduleUpdate];
    // Cria efeitos
    float dt = 0.2f;
    CCScaleBy *a1 = [CCScaleBy actionWithDuration:dt scale:0.5f];
    CCFadeOut *a2 = [CCFadeOut actionWithDuration:dt];
    CCSpawn *s1 = [CCSpawn actionWithArray:
                   [NSArray arrayWithObjects:a1, a2, nil]];
    // Método a ser executado após efeito
    CCCallFunc *c1 = [CCCallFunc actionWithTarget:self
                                         selector:@selector(removeMe:)];
    // Executa efeito
    [self runAction:[CCSequence actionWithArray:
                     [NSArray arrayWithObjects:s1, c1, nil]]];
    
    if ([self.delegate respondsToSelector:@selector(meteorWillBeRemoved:)]) {
        [self.delegate meteorWillBeRemoved:self];
        
    }

}
;
-(void)removeMe:(id)sender
{
     [self removeFromParentAndCleanup:YES];
}

@end
