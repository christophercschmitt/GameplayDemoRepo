//
//  GameScene.m
//  Scavenger
//
//  Created by Chris on 10/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
#import "HelloWorldScene.h"

@implementation GameScene

+(id) scene
{
	CCScene *scene = [CCScene node];
	GameScene *layer = [GameScene node];
	[scene addChild: layer];
	
	return scene;
}

-(id) init
{
	if( (self=[super init] ))
	{
		CCLabelTTF *message = [CCLabelTTF labelWithString:@"Greetings" fontName:@"Courier" fontSize:64];
		message.position = ccp(240,160);
		[self addChild:message];
	}
	return self;
}


/*
-(void)addBlast:(CCSprite *) missile {
	
	CCAnimation* explosionAnim = [CCAnimation animationWithName:@"explosionAnim" delay:0.2f];
	for( int i=1;i<8;i++)
		[explosionAnim addFrameWithFilename: [NSString stringWithFormat:@"bear%d.png", i]];	
	
	CCSprite *blast = [CCSprite spriteWithFile:@"Target.png" 
										  rect:CGRectMake(0, 0, 27, 40)]; 
	
	blast.tag = 4;
	//[_explosionArray addObject:blast];
	// Determine where to spawn the target along the Y axis
	
	// Create the target slightly off-screen along the right edge,
	// and along a random position along the Y axis as calculated above
	//blast.position = ccp(winSize.width/2, winSize.height/2);
	blast.position = ccp(missile.position.x, missile.position.y);
	blast.scale = 0.3;
	blast.color = ccc3( 255,0,0);
	
	[HelloWorld addChild:blast]; //target's position is set before it's added to self. addChild must just make an object visible
	
	// Determine speed of the target
	
	
	[blast runAction:[CCSequence actions:
					  [CCAnimate actionWithAnimation: explosionAnim restoreOriginalFrame:NO],
					  [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)],
					  nil]];
	//you can set up actions first and place them in sequence, or put them right in the runAction:CCSequence
}
*/

- (void) dealloc
{
	[super dealloc];
}

@end
