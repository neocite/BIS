//
//  GameScene.m
//  BIS
//
//  Created by Paulo on 30/07/13.
//  Copyright 2013 neocite. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

+ (CCScene *)scene
{
    // 'scene' is an autorelease object.
    CCScene *scene = [CCScene node];
    // 'layer' is an autorelease object.
    GameScene *layer = [GameScene node];
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
        
        
        self.meteorsLayer = [CCLayer node];
        [self addChild:self.meteorsLayer];
        
        self.playerLayer = [CCLayer node];
        [self addChild:self.playerLayer];
        
        // CCLayer para os Tiros
        self.shootsLayer = [CCLayer node];
        [self addChild:self.shootsLayer];
        
        self.scoreLayer = [CCLayer node];
        [self addChild:self.scoreLayer];
        
        [self addGameObjects];
        [self createButtons];
        
        [[SimpleAudioEngine sharedEngine]
         playBackgroundMusic:@"spy-game-action.mp3" loop:YES];
        
    }
    return self;
}

- (void)startFinalScreen {
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionPageTurn transitionWithDuration:1.0
                                        scene:[FinalScreen scene]]];
}

-(void)startGameOver
{
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionPageTurn transitionWithDuration:1.0
                                            scene:[GameOver scene]]];
}

- (void)preloadCache
{
    // Cache de sons do Jogo
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"loud-scream.aiff"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"rocket-exhaust.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"explosion.mp3"];
}

-(void)createButtons
{
    
    self.gameButtonsLayer = [CCLayer node];
    [self addChild:self.gameButtonsLayer];
    
    // Cria os botões
    CCMenuItemGameButton *leftControl = [CCMenuItemGameButton
                                         itemWithNormalSprite:[CCSprite spriteWithFile:kLEFTCONTROL]
                                         selectedSprite:[CCSprite spriteWithFile:kLEFTCONTROL]
                                         target:self
                                         selector:@selector(moveLeft:)];
    
    CCMenuItemGameButton *rightControl = [CCMenuItemGameButton
                                          itemWithNormalSprite:[CCSprite spriteWithFile:kRIGHTCONTROL]
                                          selectedSprite:[CCSprite spriteWithFile:kRIGHTCONTROL]
                                          target:self
                                          selector:@selector(moveRight:)];
 
    
    CCMenuItemGameButton *shootButton = [CCMenuItemGameButton
                                         itemWithNormalSprite:[CCSprite spriteWithFile:kSHOOTBUTTON]
                                         selectedSprite:[CCSprite spriteWithFile:kSHOOTBUTTON]
                                         target:self
                                         selector:@selector(shoot:)];
    // Define as posições dos botões
    leftControl.position = ccp(-110.0f,
                               (SCREEN_HEIGHT() / -2.0f) + 50.0f);
    
    rightControl.position = ccp((SCREEN_WIDTH() / 2.0f) - 50.0f,
                                (SCREEN_HEIGHT() / -2.0f) + 50.0f);
    
    shootButton.position = ccp(0.0f,
                               (SCREEN_HEIGHT() / -2.0f) + 50.0f);
    // Cria o menu que terá os botões
    CCMenu *menu = [CCMenu menuWithItems:leftControl,
                    rightControl,
                    shootButton,
                    nil];
    [self.gameButtonsLayer addChild:menu];
    
}


- (void)moveLeft:(id)sender
{
    [self.player moveLeft];
}
- (void)moveRight:(id)sender
{
    [self.player moveRight];
}
- (void)moveUp:(id)sender
{
    [self.player moveUp];
}
- (void)shoot:(id)sender
{
    [self.player shoot];
}

      


- (void)meteorsEngineDidCreateMeteor:(Meteor *)meteor
{
    [self.meteorsLayer addChild:meteor];
    [meteor start];
    meteor.delegate = self;
    [self.meteorsArray addObject:meteor];
}

- (void)onEnter
{
    [super onEnter];
    [self startGame];
}

- (void)startGame
{
    [self startEngines];
    [self schedule:@selector(checkHits:)];
}

- (void)startEngines
{
    [self addChild:self.meteorsEngine];
    self.meteorsEngine.delegate = self;
}

- (void)addGameObjects
{
    // Inicializa os Arrays
    self.meteorsArray = [NSMutableArray array];
    // Inicializa a Engine de Meteoros
    self.meteorsEngine = [MeteorsEngine meteorEngine];
    
    self.player = [Player player];
    self.player.delegate = self;
    [self.playerLayer addChild:self.player];
    
    self.score = [Score score];
    [self.scoreLayer addChild:self.score];
    
    self.playersArray = [NSMutableArray array];
    [self.playersArray addObject:self.player];
    
    self.shootsArray = [NSMutableArray array];
}

- (BOOL)checkRadiusHitsOfArray:(NSArray *)array1
                  againstArray:(NSArray *)array2
                    withSender:(id)sender
             andCallbackMethod:(SEL)callbackMethod
{
    BOOL result = NO;
    for (int i = 0; i < [array1 count]; i++) {
        // Pega objeto do primeiro array
        CCSprite *obj1 = [array1 objectAtIndex:i];
        CGRect rect1 = obj1.boundingBox;
        for (int j = 0; j < [array2 count]; j++) {
            // Pega objeto do segundo array
            CCSprite *obj2 = [array2 objectAtIndex:j];
            CGRect rect2 = obj2.boundingBox;
            // Verifica colisão
            if (CGRectIntersectsRect(rect1, rect2)) {
                NSLog(@"Colisão Detectada: %@",
                      NSStringFromSelector(callbackMethod));
                result = YES;
                
                if ([sender respondsToSelector:callbackMethod]) {
                    [sender performSelector:callbackMethod
                                 withObject:[array1 objectAtIndex:i]
                                 withObject:[array2 objectAtIndex:j]];
                }
                
                // Se encontrou uma colisão, sai dos 2 loops
                i = [array1 count] + 1;
                j = [array2 count] + 1;
            }
        } }
    return result;
}

- (void)playerHit:(id)player withMeteor:(id)meteor
{
    // Quando houve uma colisão entre Player e Meteoro,
    // indica que ambos foram atingidos
    if ([player isKindOfClass:[Player class]]) {
        [(Player *)player explode];
    }
    if ([meteor isKindOfClass:[Meteor class]]) {
        [(Meteor *)meteor gotShot];
    }
    [self startGameOver];
}



- (void)meteorHit:(id)meteor withShoot:(id)shoot
{
    // Quando houve uma colisão entre Meteoro e Tiro, indica que
    // o Meteoro foi atingido e que o Tiro deve explodir
    if ([meteor isKindOfClass:[Meteor class]]) {
        [(Meteor *)meteor gotShot];
    }
    if ([shoot isKindOfClass:[Shoot class]]) {
        [(Shoot *)shoot explode];
    }
      [self.score increase];
    
    
    if((self.score.score % 10)==0 )
    {
        [self.meteorsEngine increaseDifficulty];
    }
    
    if (self.score.score >= 100) {
        [self startFinalScreen];
    }
}

- (void)checkHits:(float)dt
{
    // Checa se houve colisão entre Meteoros e Tiros
    [self checkRadiusHitsOfArray:self.meteorsArray
                    againstArray:self.shootsArray
                      withSender:self
               andCallbackMethod:@selector(meteorHit:withShoot:)];
    // Checa se houve colisão entre Jogador(es) e Meteoros
    [self checkRadiusHitsOfArray:self.playersArray
                    againstArray:self.meteorsArray
                      withSender:self
               andCallbackMethod:@selector(playerHit:withMeteor:)];
}

- (void)playerDidCreateShoot:(Shoot *)shoot
{
    // O Player indicou que um novo Tiro foi criado
    [self.shootsLayer addChild:shoot];
    shoot.delegate = self;
    [shoot start];
    [self.shootsArray addObject:shoot];

}

- (void)shootWillBeRemoved:(Shoot *)shoot
{
    // Após explodir, um Tiro notifica a GameScene
    // para que seja removido do Array
    shoot.delegate = nil;
    [self.shootsArray removeObject:shoot];
}

- (void)meteorWillBeRemoved:(Meteor *)meteor
{
    // Após atingido, um Meteoro notifica a GameScene
    // para que seja removido do Array
    meteor.delegate = nil;
    [self.meteorsArray removeObject:meteor];
}

- (void)dealloc
{
    [_meteorsEngine release];
    [_meteorsArray release];
    [_meteorsLayer release];
    [super dealloc];
}

@end
