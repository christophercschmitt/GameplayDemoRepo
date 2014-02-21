//
//  WorldMapScene.m
//  Scavenger
//
//  Created by Chris on 10/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WorldMapScene.h"
#import "HelloWorldScene.h"
#import "CCEnemySprite.h"

@implementation WorldMapScene

//declare external variables
int currentLevel;
NSMutableArray *squadArray;

//declare variables
int level;

NSMutableArray *nodeCGPointArray;
NSMutableArray *nodeArray;

+(id) scene
{
	CCScene *scene = [CCScene node];
	WorldMapScene *layer = [WorldMapScene node];
	[scene addChild: layer];
	return scene;
}

-(id) init
{
	if( (self=[super init] ))
	{
		//CCLabel *title = [CCLabel labelWithString:@"World Map" fontName:@"Courier" fontSize:32];
		//title.position = ccp(240,280);
		//[self addChild: title];
		
		CGSize winSize = [CCDirector sharedDirector].winSize;
		
		nodeCGPointArray = [[NSMutableArray alloc] init];
		nodeArray = [[NSMutableArray alloc] init];
		
		//quickfix
		currentLevel = 1;
		
		CCSprite *titleImage = [CCSprite spriteWithFile:@"worldMapTitle.png"];// rect:CGRectMake(0, 0, 500, 380)];
		titleImage.position = ccp(240, 250);
		[self addChild:titleImage];
		
		CCEnemySprite *background = [CCEnemySprite spriteWithFile:@"starryNight.png"];
		background.position = ccp(winSize.width/2, winSize.height/2);
		background.scale = 2.0;
		[self addChild:background];
		
		
		
		//CCLabel *subTitle = [CCLabel labelWithString:@"Select Next Mission" fontName:@"Courier" fontSize:16];
		//subTitle.position = ccp(240,238);
		//[self addChild: subTitle];
		
		CCLayer *menuLayer = [[CCLayer alloc] init];
		[self addChild:menuLayer];
		
		CCMenuItemImage *mission01 = [CCMenuItemImage
										itemFromNormalImage:@"mission01Button.png"
										selectedImage:@"mission01Button.png"
										target:self
										selector:@selector(startMission01)];
		CCMenuItemImage *mission02 = [CCMenuItemImage
									   itemFromNormalImage:@"mission02Button.png"
									   selectedImage:@"mission02Button.png"
									   target:self
									   selector:@selector(startMission02)];
		CCMenuItemImage *mission03 = [CCMenuItemImage
									   itemFromNormalImage:@"mission03Button.png"
									   selectedImage:@"mission03Button.png"
									   target:self
									   selector:@selector(startMission03)];
		CCMenuItemImage *mission04 = [CCMenuItemImage
									   itemFromNormalImage:@"mission04Button.png"
									   selectedImage:@"mission04Button.png"
									   target:self
									   selector:@selector(startMission04)];
		
		CCMenu *menu = [CCMenu menuWithItems: mission01, mission02, mission03, mission04, nil];
		[menu alignItemsHorizontally];
		menu.position = ccp(240,120);
		[menuLayer addChild:menu];
		
		if (currentLevel == 1)
		{
			CGPoint nodePos01 = ccp(0, 40);
			[nodeCGPointArray addObject:[NSValue valueWithCGPoint:nodePos01]];
			CGPoint nodePos02 = ccp(100, 50);
			[nodeCGPointArray addObject:[NSValue valueWithCGPoint:nodePos02]];
			CGPoint nodePos03 = ccp(200, 30);
			[nodeCGPointArray addObject:[NSValue valueWithCGPoint:nodePos03]];
			CGPoint nodePos04 = ccp(300, 40);
			[nodeCGPointArray addObject:[NSValue valueWithCGPoint:nodePos04]];
			CGPoint nodePos05 = ccp(400, 30);
			[nodeCGPointArray addObject:[NSValue valueWithCGPoint:nodePos05]];
			CGPoint nodePos06 = ccp(480, 50);
			[nodeCGPointArray addObject:[NSValue valueWithCGPoint:nodePos06]];
		}
		
		int tagNumber = 1;
		
		for (NSValue *point in nodeCGPointArray)
		{
			CCEnemySprite *node = [CCEnemySprite spriteWithFile:@"node.png"];
			node.scale = 0.5;
			CGPoint newPoint = [point CGPointValue];
			node.position = newPoint;
			node.tag = tagNumber;
			[nodeArray addObject:node];
			[self addChild:node z:2];
			
			tagNumber++;
		}
		
		CGPoint previousNode = ccp(0, 0); //assign null by default, it will then populate during the loop
		BOOL onFirstNode = TRUE;
		
		//this will count nodes as we cycle through the array in the following loop, and keep track of the last available node
		int nodeCount = 0;
		
		//now draw lines between each node
		for (CCEnemySprite* node in nodeArray)
		{
			nodeCount++; //counts the nodes so when this loop is done, we'll know how many are on this level
			
			//we'll cycle through all the nodes and draw lines between each one
			//we need to skip the first node, because the lines is always drawn between the current node and previous one
			//in the case of the first node, there is no "previous" node to draw to, so we skip it
			//when we reach the last node, the final line is drawn and then we exit this loop
			
			if (onFirstNode == TRUE)
			{
				//previousNode = node.position;
				onFirstNode = FALSE;
			}
			else
			{
				//if we've passed the first node already, start drawing lines between previous node and this one
				
				//NSLog(@"drawing line from this node to previous node...");
				
				//CCLOG(@"lastTouchPoint is now(%f,%f), location is (%f,%f)", lastTouchPoint.x, lastTouchPoint.y, location.x, location.y);
				CGPoint diff = ccpSub(node.position, previousNode);
				float rads = atan2f( diff.y, diff.x);
				float degs = -CC_RADIANS_TO_DEGREES(rads);
				float dist = ccpDistance(previousNode, node.position);
				float lengthOfLineSprite = 59; //pixel length of line sprite, used to calculate how long "dist"/scale should be
				dist = dist / ( lengthOfLineSprite / 2 ); //set dist equivalent to line sprite's pixel width divided by 2
				//not sure why the above equation requires sprite length to be divided by 2, but I think it had to with retina resolution
				CCEnemySprite *line = [CCEnemySprite spriteWithFile:@"path.png"];
				//line.position = node.position;
				[line setAnchorPoint:ccp(0.0f, 0.5f)];
				[line setPosition:previousNode];
				[line setScaleX:dist];
				[line setRotation: degs];
				[self addChild:line z:1];
				
				
			}
			
			previousNode = node.position;
			
		}
		 
		 
		
		//add a "stats" label to each squad member
		for (CCEnemySprite *squadMember in squadArray)
		{
			//create a set of labels for each character
			CCLabelTTF *nameLabel = [CCLabelTTF labelWithString:@"X" dimensions:CGSizeMake(200.0f, 35.0f) alignment:UITextAlignmentLeft fontName:@"Arial" fontSize:10];
			nameLabel.position = ccp(0, 70);
			nameLabel.tag = 10;
			nameLabel.color = ccc3(255, 255, 255);
			nameLabel.anchorPoint = ccp(0.0, 0.5);
			[squadMember addChild: nameLabel];
			
			CCLabelTTF *hpLabel = [CCLabelTTF labelWithString:@"X" dimensions:CGSizeMake(200.0f, 35.0f) alignment:UITextAlignmentLeft fontName:@"Arial" fontSize:10];
			hpLabel.position = ccp(0, 60);
			hpLabel.tag = 11;
			hpLabel.color = ccc3(255, 255, 255);
			hpLabel.anchorPoint = ccp(0.0, 0.5);
			[squadMember addChild: hpLabel];
			
			CCLabelTTF *ammoLabel = [CCLabelTTF labelWithString:@"X" dimensions:CGSizeMake(200.0f, 35.0f) alignment:UITextAlignmentLeft fontName:@"Arial" fontSize:10];
			ammoLabel.position = ccp(0, 50);
			ammoLabel.tag = 12;
			ammoLabel.color = ccc3(255, 255, 255);
			ammoLabel.anchorPoint = ccp(0.0, 0.5);
			[squadMember addChild: ammoLabel];
			
			CCLabelTTF *accuracyLabel = [CCLabelTTF labelWithString:@"X" dimensions:CGSizeMake(200.0f, 35.0f) alignment:UITextAlignmentLeft fontName:@"Arial" fontSize:10];
			accuracyLabel.position = ccp(0, 40);
			accuracyLabel.tag = 13;
			accuracyLabel.color = ccc3(255, 255, 255);
			accuracyLabel.anchorPoint = ccp(0.0, 0.5);
			[squadMember addChild: accuracyLabel];
			
			CCLabelTTF *statusLabel = [CCLabelTTF labelWithString:@"X" dimensions:CGSizeMake(200.0f, 35.0f) alignment:UITextAlignmentLeft fontName:@"Arial" fontSize:10];
			statusLabel.position = ccp(0, 30);
			statusLabel.tag = 14;
			statusLabel.color = ccc3(255, 255, 255);
			statusLabel.anchorPoint = ccp(0.0, 0.5);
			[squadMember addChild: statusLabel];
			
			//fill in each label with the relevant data
			[nameLabel setString: [NSString stringWithFormat:@"%@", squadMember.characterName]];
			[hpLabel setString: [NSString stringWithFormat:@"HP: %d", squadMember.HP]];
			[ammoLabel setString: [NSString stringWithFormat:@"Am: %d", squadMember.ammo]];
			[accuracyLabel setString: [NSString stringWithFormat:@"Acc: %d", squadMember.accuracy]];
			[statusLabel setString: [NSString stringWithFormat:@"Normal"]];
		}
		
		 
		 
		//get the second-to-last and third-to-last nodes and start placing the squadMembers between them
		CCEnemySprite *secondToLastNode = (CCEnemySprite *) [self getChildByTag:(nodeCount -1)];
		CCEnemySprite *thirdToLastNode = (CCEnemySprite *) [self getChildByTag:(nodeCount -2)];
		CCEnemySprite *firstNode = (CCEnemySprite *) [self getChildByTag:1];
		CCEnemySprite *secondNode = (CCEnemySprite *) [self getChildByTag:2];
		
		float distBetweenSquadMembers = 20;
		float distToNextSquadMember = 20;
		
		//place each squad member on the map
		for (CCEnemySprite *squadMember in squadArray)
		{
			//place each member in sequence from the second-to-last node to third-to-last
			
			//first, remove the squad members from the previous scene
			[squadMember removeFromParentAndCleanup:YES]; 
			
			//and then add them to the current scene
			[self addChild:squadMember z:10];
			
			CGPoint diff = ccpSub(secondToLastNode.position, thirdToLastNode.position);
			float rads = atan2f( -diff.y, -diff.x); //use negative values because we're going "backwards" on the path
			float vx = cos(rads) * distToNextSquadMember;
			float vy = sin(rads) * distToNextSquadMember;
			CGPoint direction = ccp(vx,vy);
			
			//place member at first available node and start spacing them out toward the previous node
			squadMember.position = secondToLastNode.position;
			squadMember.position = ccpAdd(squadMember.position, direction);
			
			distToNextSquadMember += distBetweenSquadMembers;
		}
		
		
		
		
		
	}
	
	return self;
}

- (void) startMission01
{
	currentLevel = 1;
	[[CCDirector sharedDirector] replaceScene:[HelloWorld scene]];
}

- (void) startMission02
{
	currentLevel = 1;
	[[CCDirector sharedDirector] replaceScene:[HelloWorld scene]];
}

- (void) startMission03
{
	currentLevel = 2;
	[[CCDirector sharedDirector] replaceScene:[HelloWorld scene]];
}

- (void) startMission04
{
	currentLevel = 3;
	[[CCDirector sharedDirector] replaceScene:[HelloWorld scene]];
}

- (void) dealloc
{
	[super dealloc];
}

@end
