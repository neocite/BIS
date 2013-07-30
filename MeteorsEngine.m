//
//  MeteorsEngine.m
//  BIS
//
//  Created by Paulo on 30/07/13.
//  Copyright 2013 neocite. All rights reserved.
//

#import "MeteorsEngine.h"



@implementation MeteorsEngine


+ (MeteorsEngine *)meteorEngine
{
    return [[[MeteorsEngine alloc] init] autorelease];
}

- (id)init {
    self = [super init];
    if (self) {
        [self schedule:@selector(meteorsEngine:) interval:(1.0f/10.0f)];
    }
    return self;
}

- (void)meteorsEngine:(float)dt
{
    // sorte: 1 em 30 gera um novo meteoro!
    if(arc4random_uniform(30) == 0) {
        if ([self.delegate respondsToSelector:
             @selector(meteorsEngineDidCreateMeteor:)]){
            // Pede para o delegate criar o meteoro
            [self.delegate meteorsEngineDidCreateMeteor:[Meteor meteorWithImage:kMETEOR]];
        }
    }
}

@end
