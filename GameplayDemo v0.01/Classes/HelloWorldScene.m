//
// GameplayDemo - Demonstrates basic cocos2d functionality in a brief gameplay sample
//

// Import header files for other classes that we need
#import "HelloWorldScene.h"
#import "CCEnemySprite.h"

// @implementing this "HelloWorld" scene lets us later link back to this scene (in case we need to go to a pause menu or world map)
@implementation HelloWorld

//declare variables
int playerHP = 50;
int enemyHP = 10;
float playerDamageRate = 4.75;
BOOL levelObjectiveComplete = FALSE;

//declare arrays (NSMutableArrays are handy because they can be changed during the game)
NSMutableArray *enemyArray;

//enumerate types of weapons
enum weaponTypes {handgun, huntingRifle, smg, assaultRifle, shotgun};

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node]; 
	
	// 'layer' is an autorelease object.
	HelloWorld *layer = [HelloWorld node]; //layer is a HelloWorld (which is a CCLayerColor) with it's own additional properties
	
	// add layer as a child to scene
	[scene addChild: layer]; //z:1 to set z order of layers, perhaps? i.e. stats layer over buttons layer over action layer
	
	// return the scene
	return scene;
}

#pragma mark initialization
-(id) init 
{
	if( (self=[super initWithColor:ccc4(75,75,75,255)] )) //set background color to RGB 75,75,75 and full (255) opacity
	{
		//allocate arrays
		enemyArray = [[NSMutableArray alloc] init];
		
		//get dimensions of the ipod/ipad screen
		CGSize winSize = [CCDirector sharedDirector].winSize;
		
		//add a background image and place it in the center of the screen
		CCEnemySprite *background = [CCEnemySprite spriteWithFile:@"gradientBG.jpg"];
		background.position = ccp(winSize.width/2, winSize.height/2);
		background.scale = 2.0;
		[self addChild:background];
		
		//schedule the recurring functions
		[self schedule:@selector(update:)]; //scheduling a method with a : following it means it gets called every frame
		[self schedule:@selector(spawnEnemy) interval:1.2];
		
		//enable touches so we can get user input
		self.isTouchEnabled = YES;

		//add a player to the screen
		CCEnemySprite *player = [CCEnemySprite spriteWithFile:@"greenShip.png"];
		player.scale = 2.0;
		player.flipY = YES;
		player.tag = 3; //tag the player so we can reference it later
		player.position = ccp(240,160);
		[self addChild:player];				
    }
    return self; //return whether initialization was successful (app will quit safely, if not)
}

#pragma mark update
- (void)update:(ccTime)dt 
{	
	//get the player sprite
	CCEnemySprite *player = (CCEnemySprite *) [self getChildByTag:3];
	
	//define the rectangle around the player than we want enemies to collide with
	CGRect playerRect = CGRectMake(
									player.position.x - player.contentSize.width / 2, 
									player.position.y - player.contentSize.height / 2, 
									player.contentSize.width, 
									player.contentSize.height);
	
	for (CCEnemySprite *enemy in enemyArray)
	{
		//define the rectangle around the enemy that can collide with the player
		CGRect enemyRect = CGRectMake(
									   enemy.position.x - enemy.contentSize.width / 2, 
									   enemy.position.y - enemy.contentSize.height / 2, 
									   enemy.contentSize.width, 
									   enemy.contentSize.height);
		
		if (CGRectIntersectsRect (playerRect, enemyRect) )
		{
			//an enemy has collided with the player, so turn it invisible
            //note that this doesn't actually remove the enemy, but in this simplified demo we don't worry about sprite cleanup
			enemy.visible = FALSE;
		}
	}
}

- (void)spawnEnemy
{
	//create an enemy sprite
	CCEnemySprite *enemy = [CCEnemySprite spriteWithFile:@"redShip.png"];
	enemy.scale = 0.5;
	enemy.tag = 5; //tag the enemy so we can remove it from the enemyArray later after it's killed
	[self addChild:enemy];
	
	//and place it randomly
	float randomX = CCRANDOM_0_1() * 480;
	float randomY = CCRANDOM_0_1() * 320;
	enemy.position = ccp(randomX, randomY);
	
	//add the enemy to the enemyArray so we can reference it later
	[enemyArray addObject:enemy];
}

-(void) registerWithTouchDispatcher //this method is called automatically, just enables touches in the scene
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

#pragma mark touch methods
-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{	
	CGPoint touchLocation = [touch locationInView: [touch view]]; //store last touch location in touchLocation	
	touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation]; //flip origin from bottom left to top left
    touchLocation = [self convertToNodeSpace:touchLocation]; //converting coords for horizontal orientation?
	
	//get the player sprite
	CCEnemySprite *player = (CCEnemySprite *) [self getChildByTag:3];
	
	//move player to where player tapped
	[player runAction: [CCMoveTo actionWithDuration:0.8 position:touchLocation]];
	
	return YES;
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event 
{    
    CGPoint touchLocation = [touch locationInView: [touch view]]; //store last touch location in touchLocation	
	touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation]; //flip origin from bottom left to top left
    touchLocation = [self convertToNodeSpace:touchLocation]; //NodeSpace?
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event 
{
	CGPoint touchLocation = [touch locationInView: [touch view]]; //store last touch location in touchLocation	
    touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation]; //flip origin from bottom left to top left
    touchLocation = [self convertToNodeSpace:touchLocation]; //NodeSpace?
}

#pragma mark spriteMoveFinished
-(void)spriteMoveFinished:(id)sender 
{
	CCSprite *sprite = (CCSprite *)sender;
	[sprite.parent removeChild:sprite cleanup:YES];
	[self removeChild:sprite.parent cleanup:YES];

	if (sprite.tag == 5) //5 = an enemy
	{
		[enemyArray removeObject:sprite]; //don't need to remove it from the array because it's done above
	} 
}

#pragma mark dealloc
// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	[super dealloc];
}

@end
