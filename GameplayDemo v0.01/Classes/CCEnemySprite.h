//
//  CCEnemySprite.h
//  Scavenger
//
//  Created by Chris on 10/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CCEnemySprite : CCSprite 
{
	CGPoint dragStartPoint;
	BOOL nextNodeNumber;
	BOOL isBeingDragged;
	BOOL touchingBlueDefense;
	BOOL touchingYellowDefense;
	BOOL touchingRedDefense;
	BOOL touchingGreenDefense;
	BOOL glowing; //set to FALSE by default, glowing sprites are becoming whtie-hot and about to burst
	BOOL addedShotDelay;
	int spriteColor; //tracks current color for ColorSwipe game
	float scaledWidth;
	float scaledHeight;
	int currentWalkFrame;
	int HP; //used to track the level of damage, as well as health (i.e. 50% HP = damage stage 1, etc)
	int maxHP;
	int enemyType;
	int damageState;
	int hasShield; //0 = no, 1 = weak shield, 2 = med shield
	int primaryWeapon;
	int secondaryWeapon;
	int primaryWeaponCooldownMax;
	int secondaryWeaponCooldownMax;
	int primaryWeaponCooldownTimer;
	int secondaryWeaponCooldownTimer;
	int reloadingCooldownTimer;
	int ammo;
	int accuracy;
	int currentManeuver;
	int behavior;
	float horizontalThrust;
	float verticalThrust;
	float direction;
	NSString* characterName;
}

@property CGPoint dragStartPoint;
@property BOOL nextNodeNumber;
@property BOOL isBeingDragged;
@property BOOL touchingBlueDefense;
@property BOOL touchingYellowDefense;
@property BOOL touchingRedDefense;
@property BOOL touchingGreenDefense;
@property BOOL glowing;
@property BOOL addedShotDelay;
@property int spriteColor;
@property float scaledWidth;
@property float scaledHeight;
@property int currentWalkFrame;
@property int HP; //used to track the level of damage, as well as health (i.e. 50% HP = damage stage 1, etc)
@property int maxHP;
@property int enemyType;
@property int damageState;
@property int hasShield; //0 = no, 1 = weak shield, 2 = med shield
@property int primaryWeapon;
@property int secondaryWeapon;
@property int primaryWeaponCooldownMax;
@property int secondaryWeaponCooldownMax;
@property int primaryWeaponCooldownTimer;
@property int secondaryWeaponCooldownTimer;
@property int reloadingCooldownTimer;
@property int ammo;
@property int accuracy;
@property int currentManeuver;
@property int behavior;
@property float horizontalThrust;
@property float verticalThrust;
@property float direction;
@property NSString* characterName;

//-(void) firePrimary;

@end
