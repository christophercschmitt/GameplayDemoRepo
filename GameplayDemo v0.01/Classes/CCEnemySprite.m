//
//  CCEnemySprite.m
//  Scavenger
//
//  Created by Chris on 10/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CCEnemySprite.h"
#import "HelloWorldScene.h"

@implementation CCEnemySprite

@synthesize currentWalkFrame;
@synthesize nextNodeNumber;
@synthesize isBeingDragged;
@synthesize dragStartPoint;
@synthesize touchingBlueDefense;
@synthesize touchingYellowDefense;
@synthesize touchingRedDefense;
@synthesize touchingGreenDefense;
@synthesize glowing;
@synthesize addedShotDelay;
@synthesize spriteColor;
@synthesize scaledWidth;
@synthesize scaledHeight;
@synthesize HP; //current HP
@synthesize maxHP; //maximum HP
@synthesize damageState;
@synthesize enemyType;
@synthesize hasShield; //0 = no, 1 = weak shield, 2 = med shield
@synthesize primaryWeapon;
@synthesize secondaryWeapon;
@synthesize primaryWeaponCooldownMax;
@synthesize secondaryWeaponCooldownMax;
@synthesize primaryWeaponCooldownTimer;
@synthesize secondaryWeaponCooldownTimer;
@synthesize reloadingCooldownTimer;
@synthesize ammo;
@synthesize accuracy;
@synthesize currentManeuver;
@synthesize behavior;
@synthesize horizontalThrust;
@synthesize verticalThrust;
@synthesize direction;
@synthesize characterName;

/*
 -(void) firePrimary
 {
 NSLog(@"fire!");
 CCSprite *strafer2 = [CCSprite spriteWithFile:@"Icon.png" 
 rect:CGRectMake(0, 0, 64, 64)]; 
 //strafer2.color = ccc3( 255,0,0);
 //[_activeEnemies addObject:strafer];
 strafer2.position = ccp(350, 200);
 //strafer.behavior = sniping;
 [self addChild:strafer2 z:100];
 }
 */

@end