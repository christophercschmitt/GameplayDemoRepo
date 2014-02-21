//
//  MenuItemComplete.h
//  Scavenger
//
//  Created by Chris on 10/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MenuItemComplete : CCMenuItem <CCRGBAProtocol> 
{
    CCLabelTTF *_title;
    CCNode<CCRGBAProtocol> *_sprite;
    CCNode<CCRGBAProtocol> *_spriteDisabled;
    float originalScale;
	int myMenuTag;
//	int testVal;
}

@property int myMenuTag;
@property (nonatomic,readwrite,retain) CCNode<CCRGBAProtocol> *sprite;
@property (nonatomic,readwrite,retain) CCNode<CCRGBAProtocol> *spriteDisabled;
@property (nonatomic,readwrite,retain) CCLabelTTF *title;
//@property (nonatomic,readwrite) int testVal;

-(id) initFromImage:(NSString*)image title:(CCLabelTTF *)title target:(id)target selector:(SEL)selector;
//-(void) activate;
//-(void) selected;
//-(void) unselected;

@end
