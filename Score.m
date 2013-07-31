//
//  Score.m
//  BIS
//
//  Created by Paulo on 30/07/13.
//  Copyright 2013 neocite. All rights reserved.
//

#import "Score.h"


@implementation Score

+ (Score *)score
{
    return [[[Score alloc] init] autorelease];
}

- (id)init {
    self = [super init];
    if (self) {
        // Inicializa a pontuação com o valor "0"
        self.score = 0;
        // Posiciona o Placar recém criado
        self.position = ccp(SCREEN_WIDTH() - 50.0f, SCREEN_HEIGHT() - 50.0f);
        self.text = [CCLabelBMFont labelWithString:
                    [NSString stringWithFormat:@"%d%@", self.score,@"/100"]
                    fntFile:@"UniSansBold_AlphaNum_50.fnt"];
        self.text.scale = (float)(240.0f / 240.0f);
        [self addChild:self.text];
    }
    return self;
}

- (void)increase
{
    // Aumenta a pontuação e atualiza o Placar
    self.score++;
    self.text.string = [NSString stringWithFormat:@"%d%@", self.score,@"/100"];
}


@end
