//
//  InventoryScene.m
//  Scavenger
//
//  Created by Chris on 10/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "InventoryScene.h"
#import "HelloWorldScene.h"
#import "MenuItemComplete.h"
#import "WorldMapScene.h"

@implementation InventoryScene

extern id quickSlot01;
extern id quickSlot02;
extern id quickSlot03;
extern BOOL UIBarRequiresUpdate;

BOOL selectedItemIsEquippable = NO;

NSMutableArray *inventoryButtonArray;
NSMutableArray *UIButtonArray;
NSMutableArray *labelArray;
NSArray *inventoryArray;

+(id) scene
{
	CCScene *scene = [CCScene node];
	InventoryScene *layer = [InventoryScene node];
	[scene addChild: layer];
	return scene;
}

int threeTwenty = 200;

-(id) init
{
	if( (self=[super init] ))
	{
		self.isTouchEnabled = YES;
		
		//_menuStuff = [[NSMutableArray alloc] init];
		inventoryButtonArray = [[NSMutableArray alloc] init];
		UIButtonArray = [[NSMutableArray alloc] init];
		labelArray = [[NSMutableArray alloc] init];
		inventoryArray = [[NSMutableArray alloc] init];
		
		scrollLayer = [[CCLayerColor alloc] init];
		
		//scrollLayer.color = ccc3(255,0,0);
		scrollLayer.anchorPoint = ccp( 0, 1 );
		scrollLayer.position = ccp( 150, threeTwenty );
		[self addChild:scrollLayer];
		
		CCLabelTTF *itemNameLabel = [CCLabelTTF labelWithString:@" " fontName:@"Courier" fontSize:16];
		itemNameLabel.position = ccp(340,300);
		itemNameLabel.anchorPoint = ccp(0,0.5);
		itemNameLabel.tag = 4; //3 will refer to the ammo label that goes in the bottom bar to display current weap's ammo
		[self addChild: itemNameLabel];
		[labelArray addObject: itemNameLabel];
		
		CCLabelTTF *itemDamageLabel = [CCLabelTTF labelWithString:@"Damage:" fontName:@"Courier" fontSize:16];
		itemDamageLabel.position = ccp(340,280);
		itemDamageLabel.anchorPoint = ccp(0,0.5);
		itemDamageLabel.tag = 1; //3 will refer to the ammo label that goes in the bottom bar to display current weap's ammo
		[self addChild: itemDamageLabel];
		[labelArray addObject: itemDamageLabel];
		
		CCLabelTTF *itemFireRateLabel = [CCLabelTTF labelWithString:@"Fire Rate:" fontName:@"Courier" fontSize:16];
		itemFireRateLabel.position = ccp(340,260);
		itemFireRateLabel.anchorPoint = ccp(0,0.5);
		itemFireRateLabel.tag = 2; //3 will refer to the ammo label that goes in the bottom bar to display current weap's ammo
		[self addChild: itemFireRateLabel];
		[labelArray addObject: itemFireRateLabel];
		
		CCLabelTTF *itemValueLabel = [CCLabelTTF labelWithString:@"Value:" fontName:@"Courier" fontSize:16];
		itemValueLabel.position = ccp(340,240);
		itemValueLabel.anchorPoint = ccp(0,0.5);
		itemValueLabel.tag = 3; //3 will refer to the ammo label that goes in the bottom bar to display current weap's ammo
		[self addChild: itemValueLabel];
		[labelArray addObject: itemValueLabel];
					
		/*
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
		CCMenuItemImage *mission04 = [CCMenuItemImage
									  itemFromNormalImage:@"Icon.png"
									  selectedImage:@"Player.png"
									  target:self
									  selector:@selector(startGame:)];
		CCMenuItemImage *mission05 = [CCMenuItemImage
									  itemFromNormalImage:@"Icon.png"
									  selectedImage:@"Player.png"
									  target:self
									  selector:@selector(startGame:)];
		CCMenuItemImage *mission06 = [CCMenuItemImage
									  itemFromNormalImage:@"Icon.png"
									  selectedImage:@"Player.png"
									  target:self
									  selector:@selector(startGame:)];
		CCMenuItemImage *mission07 = [CCMenuItemImage
									  itemFromNormalImage:@"Icon.png"
									  selectedImage:@"Player.png"
									  target:self
									  selector:@selector(startGame:)];
		CCMenuItemImage *mission08 = [CCMenuItemImage
									  itemFromNormalImage:@"Icon.png"
									  selectedImage:@"Player.png"
									  target:self
									  selector:@selector(startGame:)];
		CCMenuItemImage *mission09 = [CCMenuItemImage
									  itemFromNormalImage:@"Icon.png"
									  selectedImage:@"Player.png"
									  target:self
									  selector:@selector(startGame:)];
		
		CCMenu *menu = [CCMenu menuWithItems: mission01, mission02, mission03, mission04, mission05, mission06, mission07, //nil];
		nil];
		menu.position = ccp(0,-100 - (32 * 7) );
		[scrollLayer addChild:menu z:10];
		menu.isRelativeAnchorPoint = YES;
		menu.anchorPoint = ccp(0.0f,0.0f);
		[menu alignItemsVertically];
		*/
		
		//NSString level01[10] = {@"test1",@"test2",@"test3"};
		
		/*
		 NSArray* playerInventory = [NSArray arrayWithObjects: 
		 @"Lev 1 Engine", @"Laser Cannon",
		 @"Scrap Metal", @"Gauss Repeater", 
		 @"Auto Turret", nil];
		 int numberOfItems = [playerInventory count];
		 */
		
		//int numberOfItems = 3; //find a way to derive this number from the array. Does .count work?
		//int inventoryArray[10] = {1,2,3,4,5};
		
		CCMenu* inventoryMenu = [CCMenu menuWithItems: nil];
		
		//the weaponNames array holds the item names that correspond to the integers in inventoryArray, so if the first item
		//the player collects is a "2", it's string will show up as "Laser Cannon" in their inventory
		//NSString *itemNames[10] = {@"X_UNUSED STRING", @"Lev 1 Engine", @"Laser Cannon", @"Scrap Metal", @"Gauss Repeater", @"Auto Turret"};
		/*
		NSArray *inventoryArray = [NSArray arrayWithObjects: 
									@"Lev 1 Engine", @"Laser Cannon",
									@"Scrap Metal", @"Gauss Repeater", 
									@"Auto Turret", nil];
		 */
		[inventoryArray addObject: @"Lev 1 Engine"];
		[inventoryArray addObject: @"Laser Cannon"];
		[inventoryArray addObject: @"Missile Launcher"];
		//generate all menu buttons based on inventoryArray's contents
		for(int i=0; i < inventoryArray.count; i++) 
		{
			MenuItemComplete *inventoryItem = [[MenuItemComplete alloc] initFromImage:@"engineLev1Icon.png" title:[CCLabelTTF labelWithString:[inventoryArray objectAtIndex:i] fontName:@"Courier" fontSize:20] target: self selector:@selector(startGame:)];
			//MenuItemComplete *inventoryItem = [[MenuItemComplete alloc] initFromImage:@"Icon.png" title:[CCLabel labelWithString:itemNames[inventoryArray[i]] fontName:@"Courier" fontSize:20] target: self selector:@selector(startGame:)];
			if (i == 0)
			{
				//inventoryItem.normalImage = [CCSprite spriteWithFile:@"engineLev1Icon.png"];
				//inventoryItem.sprite = [[CCTexture2D alloc]initWithImage:[UIImage imageNamed:@"laserIcon.png"]];
				inventoryItem.sprite = [CCSprite spriteWithFile:@"engineLev1Icon.png"];
			}
			else if (i == 1)
			{
				//MenuItemComplete *inventoryItem = [[MenuItemComplete alloc] initFromImage:@"laserIcon.png" title:[CCLabel labelWithString:[inventoryArray objectAtIndex:i] fontName:@"Courier" fontSize:20] target: self selector:@selector(startGame:)];
				inventoryItem.sprite = [CCSprite spriteWithFile:@"laserIcon.png"];
			}
			else
			{
				//MenuItemComplete *inventoryItem = [[MenuItemComplete alloc] initFromImage:@"bombIcon.png" title:[CCLabel labelWithString:[inventoryArray objectAtIndex:i] fontName:@"Courier" fontSize:20] target: self selector:@selector(startGame:)];
				inventoryItem.sprite = [CCSprite spriteWithFile:@"bombIcon.png"];
			}
			//menuItem2.originalScale = 3;
			inventoryItem.myMenuTag = i; //i is the current item number, so 
			[inventoryMenu addChild: inventoryItem];
			//[_menuStuff addObject:inventoryItem];
			[inventoryItem release];
		}
		
		//now that all menu buttons have been generated, align them vertically and add them to the scene
		[inventoryMenu alignItemsVerticallyWithPadding:4];
		int menuYPos = -100 - (30 * inventoryArray.count);
		inventoryMenu.position = ccp(-100,menuYPos);
		//inventoryMenu.position = ccp(-100,-100 - (30 * inventoryArray.count) );//need to adjust this number to get it to line up perfectly, but it's very close now
		[scrollLayer addChild:inventoryMenu z:10];
		
		MenuItemComplete *backButton = [[MenuItemComplete alloc] initFromImage:@"Icon.png" title:[CCLabelTTF labelWithString:@"Back" fontName:@"Courier" fontSize:20] target: self selector:@selector(returnToGame)];
		CCMenu *backButtonMenu = [CCMenu menuWithItems: backButton, nil];
		backButtonMenu.position = ccp(360,107);
		[self addChild:backButtonMenu];
		
		MenuItemComplete *equipButton = [[MenuItemComplete alloc] initFromImage:@"Icon.png" title:[CCLabelTTF labelWithString:@"Equip" fontName:@"Courier" fontSize:20] target: self selector:@selector(equipItem)];
		CCMenu *equipButtonMenu = [CCMenu menuWithItems: equipButton, nil];
		equipButtonMenu.position = ccp(358,200);
		equipButton.scale = 0.7;
		equipButton.visible = NO;
		[inventoryButtonArray addObject:equipButton];
		[self addChild:equipButtonMenu];
		
		CCMenuItemImage *quickSlotButton01 = [CCMenuItemImage
										itemFromNormalImage:@"Icon.png"
										selectedImage:@"Player.png"
										target:self
										selector:@selector(equipToSlot:)];
		quickSlotButton01.tag = 1;
		CCMenuItemImage *quickSlotButton02 = [CCMenuItemImage
										itemFromNormalImage:@"Icon.png"
										selectedImage:@"Player.png"
										target:self
										selector:@selector(equipToSlot:)];
		quickSlotButton02.tag = 2;
		CCMenuItemImage *quickSlotButton03 = [CCMenuItemImage
										itemFromNormalImage:@"Icon.png"
										selectedImage:@"Player.png"
										target:self
										selector:@selector(goToMainMenu:)];
		quickSlotButton03.tag = 3;
		[UIButtonArray addObject: quickSlotButton01];
		[UIButtonArray addObject: quickSlotButton02];
		[UIButtonArray addObject: quickSlotButton03];
		CCMenu *quickSlotMenu = [CCMenu menuWithItems: quickSlotButton01, quickSlotButton02, quickSlotButton03, nil];
		quickSlotMenu.position = ccp(375,40);
		[self addChild:quickSlotMenu];
		[quickSlotMenu alignItemsHorizontally];
		
		//scrolling features
		isDragging = NO;
		lasty = 0.0f;
		yvel = 0.0f;
		contentHeight = 600; // whatever you want here for total height
		
		CCSprite *background3 = [CCSprite spriteWithFile:@"Default.png" rect:CGRectMake(0, 0, 320, 480)];
		background3.position = ccp(0,0);
		[scrollLayer addChild:background3];
		
		[self updateUIBar]; //update the quickslots with the currently equipped items
		
		[self schedule:@selector(moveTick:) interval:0.02f];
	}
	
	return self;
}

//scrollin additions
- (void) moveTick: (ccTime)dt {
	float friction = 0.95f;
	
	if ( !isDragging ) 
	{
		// inertia
		yvel *= friction;
		CGPoint pos = scrollLayer.position;
		pos.y += yvel;
		pos.y = MAX( threeTwenty, pos.y );
		pos.y = MIN( contentHeight + threeTwenty, pos.y );
		scrollLayer.position = pos;
	}
	else {
		yvel = ( scrollLayer.position.y - lasty ) / 2;
		lasty = scrollLayer.position.y;
	}
	
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
	
	for (CCSprite *selectedMenu in _menuStuff) 
	{
		CGRect menuRect = CGRectMake(
									 selectedMenu.position.x - (selectedMenu.contentSize.width/2), 
									 selectedMenu.position.y - (selectedMenu.contentSize.height/2), 
									 selectedMenu.contentSize.width, 
									 selectedMenu.contentSize.height);
		
		if( CGRectContainsPoint( menuRect, touchLocation ) )
		{
			//[[CCDirector sharedDirector] popScene];
			NSLog(@"tapped a menuStuff item");
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
	CGPoint nowPosition = scrollLayer.position;
	nowPosition.y += ( b.y - a.y );
	nowPosition.y = MAX( threeTwenty, nowPosition.y );
	nowPosition.y = MIN( contentHeight + threeTwenty, nowPosition.y );
	scrollLayer.position = nowPosition;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event 
{
	isDragging = NO;
}

- (void) goToMainMenu: (id) sender
{
	//load world map scene so the player can start a new level
	[[CCDirector sharedDirector] replaceScene:[WorldMapScene scene]];
}

- (void) startGame: (id) sender
{
	MenuItemComplete *selectedMenu = (MenuItemComplete *)sender;
	//display item stats and whether it's equippable
	[self displayItemStats:selectedMenu.myMenuTag];
	//NSLog(@"inventory item #%d selected", selectedMenu.myMenuTag);
}

- (void) returnToGame
{
	//NSLog(@"closing inventory screen");
	UIBarRequiresUpdate = YES;
	[[CCDirector sharedDirector] popScene];
}

- (void) equipItem
{
	CCLabelTTF *howToEquipLabel = [CCLabelTTF labelWithString:@"Tap a quickslot to equip..." fontName:@"Arial" fontSize:16];
	howToEquipLabel.position = ccp(370,160);
	[labelArray addObject:howToEquipLabel];
	howToEquipLabel.tag = 5;
	[self addChild: howToEquipLabel];
	howToEquipLabel.opacity = 0; //starts invisible and fades in
	id seq1 = [CCSequence actions: [CCFadeIn actionWithDuration:0.5f],
			   [CCFadeOut actionWithDuration:0.5f], nil];
	[howToEquipLabel runAction: [CCRepeatForever actionWithAction:seq1]];
	
	
}

//- (void) equipToSlot: (id) sender
- (void) equipToSlot: (CCMenuItemImage *) selectedMenu
{
	//CCMenuItemImage *selectedMenu = (CCMenuItemImage *)sender;
	//display item stats and whether it's equippable
	//[self displayItemStats:selectedMenu.myMenuTag];
	if (selectedItemIsEquippable == YES)
	{
		for (CCLabelTTF *currentLabel in labelArray)
		{
			if (currentLabel.tag == 4) //name label
			{
				if (selectedMenu.tag == 1)
				{
					NSLog(@"Item Equipped to Slot 1");
					quickSlot01 = currentLabel.userData;
				}
				else if (selectedMenu.tag == 2)
				{
					NSLog(@"Item Equipped to Slot 2");
					quickSlot02 = currentLabel.userData;
				}
				else //(selectedMenu.tag == 3)
				{
					NSLog(@"Item Equipped to Slot 3");
					quickSlot03 = currentLabel.userData;
				}
			}
			if (currentLabel.tag == 5) //howToEquip label
			{
				[currentLabel stopAllActions];
				currentLabel.opacity = 0;
			}
		}
	}
	[self updateUIBar]; //update the newly equipped icons in the UI bar
}

-(void) displayItemStats: (int) itemToDisplay
{
	for (CCLabelTTF *currentLabel in labelArray)
	{
		if (currentLabel.tag == 4) //name label
		{
			//set item name label to the proper string
			[currentLabel setString: [inventoryArray objectAtIndex:itemToDisplay]];
			
			//and also store that string in the label's userdata so we can compare it later, in the equipItem method
			currentLabel.userData = [inventoryArray objectAtIndex:itemToDisplay];
		}
		if (currentLabel.tag == 5) //howToEquip label
		{
			[currentLabel stopAllActions];
			currentLabel.opacity = 0;
		}
	}
	
	if (itemToDisplay == 0)
	{
		selectedItemIsEquippable = YES;
		
		//enable "equip" button so the player can install this item
		for (MenuItemComplete *equipButton in inventoryButtonArray)
		{
		equipButton.visible = YES;
		}
		
		for (CCLabelTTF *currentLabel in labelArray)
		{
			if (currentLabel.tag == 1) //damage label
			{
				[currentLabel setString: [NSString stringWithFormat:@"Damage: 5"]];
			}
			if (currentLabel.tag == 2) //fire rate label
			{
				[currentLabel setString: [NSString stringWithFormat:@"Fire Rate: 20"]];
			}
			if (currentLabel.tag == 3) //value label
			{
				[currentLabel setString: [NSString stringWithFormat:@"Value: 250"]];
			}
		}
	}
	if (itemToDisplay == 1)
	{
		selectedItemIsEquippable = YES;
		
		for (MenuItemComplete *equipButton in inventoryButtonArray)
		{
			equipButton.visible = YES;
		}
		for (CCLabelTTF *currentLabel in labelArray)
		{
			if (currentLabel.tag == 1) //damage label
			{
				[currentLabel setString: [NSString stringWithFormat:@"Damage: 20"]];
			}
			if (currentLabel.tag == 2) //fire rate label
			{
				[currentLabel setString: [NSString stringWithFormat:@"Fire Rate: 2"]];
			}
			if (currentLabel.tag == 3) //value label
			{
				[currentLabel setString: [NSString stringWithFormat:@"Value: 400"]];
			}
		}
	}
	if (itemToDisplay == 2)
	{
		selectedItemIsEquippable = YES;
		
		for (MenuItemComplete *equipButton in inventoryButtonArray)
		{
			equipButton.visible = NO;
		}
		for (CCLabelTTF *currentLabel in labelArray)
		{
			if (currentLabel.tag == 1) //damage label
			{
				[currentLabel setString: [NSString stringWithFormat:@"Damage: 1"]];
			}
			if (currentLabel.tag == 2) //fire rate label
			{
				[currentLabel setString: [NSString stringWithFormat:@"Fire Rate: 65"]];
			}
			if (currentLabel.tag == 3) //value label
			{
				[currentLabel setString: [NSString stringWithFormat:@"Value: 300"]];
			}
		}
	}
}

-(void) updateUIBar
{
	for (CCMenuItemImage *selectedMenu in UIButtonArray)
	{
		if (selectedMenu.tag == 1) //first slot
		{
			if (quickSlot01 == @"Laser Cannon")
			{
				//set image to laser cannon icon
				//selectedMenu.color = ccc3(255,0,0);
				//selectedMenu.normalImage =[[CCTexture2D alloc]initWithImage:[UIImage imageNamed:@"laserIcon.png"]];
				//CCTexture2D *x=[[CCTexture2D alloc]initWithImage:[UIImage imageNamed:@"laserIcon.png"]];
				//[selectedMenu setNormalImage:x];
				selectedMenu.normalImage = [CCSprite spriteWithFile:@"laserIcon.png"]; 
				selectedMenu.selectedImage = [CCSprite spriteWithFile:@"laserIcon.png"];
				//selectedMenu.selectedImage.tint = ccc3(0,0,255);
			}
			if (quickSlot01 == @"Lev 1 Engine")
			{
				//set image to laser cannon icon
				//selectedMenu.color = ccc3(0,255,0);
				selectedMenu.normalImage = [CCSprite spriteWithFile:@"engineLev1Icon.png"]; 
				selectedMenu.selectedImage = [CCSprite spriteWithFile:@"engineLev1Icon.png"];
			}
			if (quickSlot01 == @"Missile Launcher")
			{
				//set image to laser cannon icon
				//selectedMenu.color = ccc3(0,0,255);
				selectedMenu.normalImage = [CCSprite spriteWithFile:@"bombIcon.png"]; 
				selectedMenu.selectedImage = [CCSprite spriteWithFile:@"bombIcon.png"];
			}
		}
		if (selectedMenu.tag == 2) //second slot
		{
			if (quickSlot02 == @"Laser Cannon")
			{
				//set image to laser cannon icon
				//selectedMenu.color = ccc3(255,0,0);
				selectedMenu.normalImage = [CCSprite spriteWithFile:@"laserIcon.png"]; 
				selectedMenu.selectedImage = [CCSprite spriteWithFile:@"laserIcon.png"];
			}
			if (quickSlot02 == @"Lev 1 Engine")
			{
				//set image to laser cannon icon
				//selectedMenu.color = ccc3(0,255,0);
				selectedMenu.normalImage = [CCSprite spriteWithFile:@"engineLev1Icon.png"]; 
				selectedMenu.selectedImage = [CCSprite spriteWithFile:@"engineLev1Icon.png"];
			}
			if (quickSlot02 == @"Missile Launcher")
			{
				//set image to laser cannon icon
				//selectedMenu.color = ccc3(0,0,255);
				selectedMenu.normalImage = [CCSprite spriteWithFile:@"bombIcon.png"]; 
				selectedMenu.selectedImage = [CCSprite spriteWithFile:@"bombIcon.png"];
			}
		}
		if (selectedMenu.tag == 3) //third slot
		{
			if (quickSlot03 == @"Laser Cannon")
			{
				//set image to laser cannon icon
				//selectedMenu.color = ccc3(255,0,0);
				selectedMenu.normalImage = [CCSprite spriteWithFile:@"laserIcon.png"]; 
				selectedMenu.selectedImage = [CCSprite spriteWithFile:@"laserIcon.png"];
			}
			if (quickSlot03 == @"Lev 1 Engine")
			{
				//set image to laser cannon icon
				//selectedMenu.color = ccc3(0,255,0);
				selectedMenu.normalImage = [CCSprite spriteWithFile:@"engineLev1Icon.png"]; 
				selectedMenu.selectedImage = [CCSprite spriteWithFile:@"engineLev1Icon.png"];
			}
			if (quickSlot03 == @"Missile Launcher")
			{
				//set image to laser cannon icon
				//selectedMenu.color = ccc3(0,0,255);
				selectedMenu.normalImage = [CCSprite spriteWithFile:@"bombIcon.png"]; 
				selectedMenu.selectedImage = [CCSprite spriteWithFile:@"bombIcon.png"];
			}
		}
	}
}

- (void) dealloc
{
	[super dealloc];
}

@end
