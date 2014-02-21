//
//  InventoryScene.h
//  Scavenger
//
//  Created by Chris on 10/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"


@interface InventoryScene : CCLayer 
{
	//scrollin addition
	CCLayerColor *scrollLayer;
	BOOL isDragging;
	float lasty;
	float yvel;
	int contentHeight;	
	NSMutableArray *_menuStuff;
}

+(id) scene;

@end
