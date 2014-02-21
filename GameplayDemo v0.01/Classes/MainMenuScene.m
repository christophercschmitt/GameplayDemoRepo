//
//  MainMenuScene.m
//  Scavenger
//
//  Created by Chris on 10/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MainMenuScene.h"
#import "HelloWorldScene.h" //so we can link straight to the game with the "load game" button
#import "WorldMapScene.h" //so we can link to the worldmap with the "new game" button

@implementation MainMenuScene

+(id) scene
{
	CCScene *scene = [CCScene node];
	MainMenuScene *layer = [MainMenuScene node];
	[scene addChild: layer];
	return scene;
}

-(id) init
{
	if( (self=[super init] ))
	{
		//CCLabel *title = [CCLabel labelWithString:@"Scavenger" fontName:@"Courier" fontSize:64];
		//title.position = ccp(240,280);
		//[self addChild: title];
		
		CCSprite *titleImage = [CCSprite spriteWithFile:@"title.png"];// rect:CGRectMake(0, 0, 500, 380)];
		titleImage.position = ccp(240, 250);
		[self addChild:titleImage];
		
		//self.weaponButton01 = [CCSprite spriteWithFile:@"Icon.png"];
		
		//CCLabel *subTitle = [CCLabel labelWithString:@"By Chris Schmitt - Copyright 2010" fontName:@"Courier" fontSize:16];
		//subTitle.position = ccp(240,238);
		//[self addChild: subTitle];
		
		CCLayer *menuLayer = [[CCLayer alloc] init];
		[self addChild:menuLayer];
		
		CCMenuItemImage *startButton = [CCMenuItemImage
										itemFromNormalImage:@"newGameButton.png"
										selectedImage:@"newGameButton.png"
										target:self
										selector:@selector(ViewWorldMap:)];
		CCMenuItemImage *loadButton = [CCMenuItemImage
										itemFromNormalImage:@"loadGameButton.png"
										selectedImage:@"loadGameButton.png"
										target:self
										selector:@selector(loadGame)];
		CCMenuItemImage *optionsButton = [CCMenuItemImage
										itemFromNormalImage:@"optionsButton.png"
										selectedImage:@"optionsButton.png"
										target:self
										selector:@selector(loadOptions)];
		
		//CCMenu *menu = [CCMenu menuWithItems: startButton, loadButton, optionsButton, nil];
		CCMenu *menu = [CCMenu menuWithItems: startButton, loadButton, optionsButton, nil];
		[menu alignItemsVertically];
		menu.position = ccp(240,120);
		[menuLayer addChild:menu];
	}
	
	return self;
}

- (void) startGame: (id) sender
{
	//NSLog (@"Testing 1 2 3..."); //displays text in the debug log
	[[CCDirector sharedDirector] replaceScene:[HelloWorld scene]];
}

- (void) loadGame
{
CCLabelTTF *loadingLabel = [CCLabelTTF labelWithString:@"Loading most recent game..." fontName:@"Arial" fontSize:16];
loadingLabel.position = ccp(240,20);
[self addChild: loadingLabel];
loadingLabel.opacity = 0; //starts invisible and fades in
	id seq1 = [CCSequence actions: [CCFadeIn actionWithDuration:0.5f],
			   [CCFadeOut actionWithDuration:0.5f], nil];
	[loadingLabel runAction: [CCRepeatForever actionWithAction:seq1]];
	//[layer1 runAction:seq1];
/*
[loadingLabel runAction: [CCSequence actions: 
						[CCFadeIn actionWithDuration:0.5f], 
						[CCDelayTime actionWithDuration:2], 
						[CCFadeOut actionWithDuration:3.0f], 
						[CCRepeatForever actionWithDuration:3]
						[CCCallFuncN actionWithTarget:self selector:nil],
						nil]];
 
 action = [CCFadeOut actionWithDuration:2];
 id action_back = [action reverse];
 id seq = [CCSequence actions:action, action_back, nil];
 
 [sprite runAction: [CCRepeatForever actionWithAction:seq]];
*/
	
}

-(void) loadOptions
{
	
}

- (void) ViewWorldMap: (id) sender
{
	[[CCDirector sharedDirector] replaceScene:[WorldMapScene scene]];
}

- (void) dealloc
{
	[super dealloc];
}

@end
