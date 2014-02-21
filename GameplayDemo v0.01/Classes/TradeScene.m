//
//  WorldMapScene.m
//  Scavenger
//
//  Created by Chris on 10/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TradeScene.h"
#import "HelloWorldScene.h"
#import "WhackAMoleAppDelegate.h"
#import "MenuItemComplete.h"

extern int whichDialogue;

@implementation TradeScene

NSMutableArray *_menuStuff;

+(id) scene
{
	CCScene *scene = [CCScene node];
	TradeScene *layer = [TradeScene node];
	[scene addChild: layer];
	return scene;
}

-(id) init
{
	if( (self=[super init] ))
	//if( (self=[super initWithColor:ccc4(255,255,255,255)] )) 

	{
		self.isTouchEnabled = YES;
		
		_menuStuff = [[NSMutableArray alloc] init];
		
		scrollLayer = [[CCLayerColor alloc] init];
		
		//scrollLayer.color = ccc3(255,0,0);
		scrollLayer.anchorPoint = ccp( 0, 0 );
		scrollLayer.position = ccp( 0, 0 );
		[self addChild:scrollLayer];
		
		//CCLabel *title = [CCLabel labelWithString:@"Dialogue" fontName:@"Courier" fontSize:32];
		//title.position = ccp(50,50);
		//title.anchorPoint = ccp(0,0);
		//[scrollLayer addChild: title z:11];
				
		//CCLayer *menuLayer = [[CCLayer alloc] init];
		//[self addChild:menuLayer];
		
		CCMenuItemImage *mission01 = [CCMenuItemImage
									  itemFromNormalImage:@"Icon.png"
									  selectedImage:@"Player.png"
									  target:self
									  selector:@selector(startGame:)];
		CCMenuItemImage *mission02 = [CCMenuItemImage
									  itemFromNormalImage:@"Icon.png"
									  selectedImage:@"Player.png"
									  target:self
									  selector:@selector(startGame:)];
		CCMenuItemImage *mission03 = [CCMenuItemImage
									  itemFromNormalImage:@"Icon.png"
									  selectedImage:@"Player.png"
									  target:self
									  selector:@selector(startGame:)];
		
		CCMenu *menu = [CCMenu menuWithItems: mission01, mission02, mission03, nil];
		[menu alignItemsVertically];
		menu.position = ccp(0,0);
		[scrollLayer addChild:menu z:10];
		
		//scrolling features
		isDragging = NO;
		lasty = 0.0f;
		yvel = 0.0f;
		contentHeight = 500; // whatever you want here for total height
		
		// main scrolling layer
		
		
		//CGSize winSize = [CCDirector sharedDirector].winSize;
		CCSprite *background3 = [CCSprite spriteWithFile:@"Default.png" rect:CGRectMake(0, 0, 320, 480)];
		background3.position = ccp(0,0);
		[scrollLayer addChild:background3];
		
		[self schedule:@selector(moveTick:) interval:0.02f];
		
		//
		
		//NSString level01[10] = {@"test1",@"test2",@"test3"};
		
		NSArray* playerInventory = [NSArray arrayWithObjects: 
							   @"Lev 1 Engine", @"Laser Cannon",
							   @"Scrap Metal", @"Gauss Repeater", 
							   @"Auto Turret", nil];
		int numberOfItems = [playerInventory count];
		
		CCMenu* mymenu = [CCMenu menuWithItems: nil];
		
		for(int i=0; i < numberOfItems; i++) 
		{
			//NSString* currentName = [panelNames objectAtIndex:i];
			//CCSprite* pane2 = [CCSprite spriteWithFile:[NSString stringWithFormat: @"Icon.png"]];
			//NMPanelMenuItem* menuItem2 = [[NMPanelMenuItem alloc] initFromNormalSprite:pane2 
			//															selectedSprite:pane2
			//															  activeSprite:pane2
			//															disabledSprite:pane2
			//																	  name:currentName
			//																	target:self selector:@selector(levelPicked:)];
			//menuItem2.world = i;
			//menuItem2.name = currentName;
			NSString *test2 = @"start";
			MenuItemComplete *menuItem2 = [[MenuItemComplete alloc] initFromImage:@"Icon.png" title:[CCLabelTTF labelWithString:test2 fontName:@"marker felt" fontSize:24] target: self selector:@selector(startGame:)];
			//menuItem2.originalScale = 3;
			menuItem2.myMenuTag = 3;
			[mymenu addChild: menuItem2];
			[_menuStuff addObject:menuItem2];
			[menuItem2 release];
		}
		
		[mymenu alignItemsVerticallyWithPadding:3];
		[self addChild:mymenu];
		
		//
		
		/*
			//MenuItemComplete *mnuKaleidoscope = [[MenuItemComplete alloc] initFromImage:@"Icon.png" title:[CCLabel labelWithString:@"Kaleidoscope" fontName:@"marker felt" fontSize:24] target: self selector: @selector(startGame:)];
			MenuItemComplete *mnuAbout = [[MenuItemComplete alloc] initFromImage:@"Icon.png" title:[CCLabel labelWithString:@"About" fontName:@"marker felt" fontSize:24] target: self selector: @selector(startGame:)];
			MenuItemComplete *mnuQuit = [[MenuItemComplete alloc] initFromImage:@"Icon.png" title:[CCLabel labelWithString:@"Quit" fontName:@"marker felt" fontSize:24] target: self selector: @selector(startGame:)];
			//CCMenu *mymenu = [CCMenu menuWithItems:mnuKaleidoscope, mnuAbout, mnuQuit, nil];
		CCMenu* mymenu = [CCMenu menuWithItems: nil];
		[mymenu addChild: mnuAbout];
		[mymenu addChild: mnuQuit];
		[mymenu alignItemsVerticallyWithPadding:3];
			[self addChild:mymenu];
			
			CCLabel * l = [CCLabel labelWithString:@"Main Menu" fontName:@"marker felt" fontSize:28];
			l.position = ccp(160,420);
			[self addChild:l];
		*/	
	}
	
	return self;
}

-(MenuItemComplete *) itemForTouch: (UITouch *) touch //old method i used for reference, lets you see which sprite was touched
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
	
	for( MenuItemComplete* item in _menuStuff ) {
		CGPoint local = [item convertToNodeSpace:touchLocation];
		
		CGRect r = [item rect];
		r.origin = CGPointZero;
		
		if( CGRectContainsPoint( r, local ) )
			return item;
	}
	return nil;
}


//scrollin additions
- (void) moveTick: (ccTime)dt {
	float friction = 0.95f;
	
	if ( !isDragging ) {
		// inertia
		yvel *= friction;
		CGPoint pos = scrollLayer.position;
		pos.y += yvel;
		//pos.y = MAX( 320, pos.y );
		pos.y = MAX( 0, pos.y );
		pos.y = MIN( contentHeight + 320, pos.y );
		//pos.y = pos.y + 1;
		scrollLayer.position = pos;
		//background.position = pos;
		//NSLog(@"hi");
	}
	else {
		yvel = ( scrollLayer.position.y - lasty ) / 2;
		lasty = scrollLayer.position.y;
	}
	
}

-(void) registerWithTouchDispatcher //this method is called automatically, just enables touches in the scene
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
//-(NSSet *) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	CGPoint touchLocation = [touch locationInView: [touch view]]; //store last touch location in touchLocation	
	touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation]; //flip origin from bottom left to top left
    touchLocation = [self convertToNodeSpace:touchLocation]; //converting coords for horizontal orientation?
	
	for (MenuItemComplete *selectedMenu in _menuStuff) 
	{
		CGRect menuRect = CGRectMake(
									   selectedMenu.position.x - (selectedMenu.contentSize.width/2), 
									   selectedMenu.position.y - (selectedMenu.contentSize.height/2), 
									   selectedMenu.contentSize.width, 
									   selectedMenu.contentSize.height);
		
		if( CGRectContainsPoint( menuRect, touchLocation ) )
		{
			[[CCDirector sharedDirector] popScene];
		}
	}
	
	NSLog(@"Touch Position: %d", touchLocation);
	
	//NSLog(@"hi");
	isDragging = YES;
	
	return YES;
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	//scrollin additions
	CGPoint a = [[CCDirector sharedDirector] convertToGL:[touch previousLocationInView:touch.view]];
	CGPoint b = [[CCDirector sharedDirector] convertToGL:[touch locationInView:touch.view]];
	//NSLog(@"PrevLoc: %d", [touch previousLocationInView:touch.view]);
	//NSLog(@"hi");
	CGPoint nowPosition = scrollLayer.position;
	nowPosition.y += ( b.y - a.y );
	nowPosition.y = MAX( 0, nowPosition.y );
	nowPosition.y = MIN( contentHeight + 320, nowPosition.y );
	scrollLayer.position = nowPosition;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event 
{
	isDragging = NO;
}

- (void) startGame: (id) sender
{
	MenuItemComplete *menu = (MenuItemComplete *)sender;
	if (menu.myMenuTag == 3)
	{
		[[CCDirector sharedDirector] popScene];
	}
	//[[CCDirector sharedDirector] popScene];
}

- (void) dealloc
{
	[super dealloc];
}

@end
