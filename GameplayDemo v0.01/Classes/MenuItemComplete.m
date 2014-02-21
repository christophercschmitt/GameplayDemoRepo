//
//  MenuItemComplete.m
//  Scavenger
//
//  Created by Chris on 10/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MenuItemComplete.h"


@implementation MenuItemComplete

@synthesize sprite = _sprite;
@synthesize spriteDisabled = _spriteDisabled;
@synthesize title = _title;
@synthesize myMenuTag;
//@synthesize testVal = testVal;
//@synthesize originalScale = _originalScale;

enum 
{
	kZoomActionTag = 1,
};

-(id) initFromImage:(NSString *)image title:(CCLabelTTF *)t target:(id)target selector:(SEL)selector
{
    if( (self=[super initWithTarget:target selector:selector]) ) {
		
        originalScale = 1;
		
        self.sprite = [CCSprite spriteWithFile:image];
        self.spriteDisabled = [CCSprite spriteWithFile:image];
        [self.spriteDisabled setOpacity:80];
        [self setContentSize: [self.sprite contentSize]];
		
        self.title = t;
		self.title.anchorPoint = ccp(0,0);
        self.title.position = ccp(80, self.contentSize.height/2);
        [self addChild: _title z:100];
    }
    return self;   
}

-(void) draw
{
    if(isEnabled_)
        [_sprite draw];             
    else
        [_spriteDisabled draw];
}

-(void) activate {
    if(isEnabled_) {
        [self stopAllActions];
		
        self.scale = originalScale;
		
        [super activate];
    }
}

-(void) selected
{
    if(isEnabled_) {   
        [super selected];
        [self stopActionByTag:kZoomActionTag];
        originalScale = self.scale;
        CCAction *zoomAction = [CCScaleTo actionWithDuration:0.1f scale:originalScale * 1.2f];
        zoomAction.tag = kZoomActionTag;
        [self runAction:zoomAction];
    }
}

-(void) unselected
{
    if(isEnabled_) {
        [super unselected];
        [self stopActionByTag:kZoomActionTag];
        CCAction *zoomAction = [CCScaleTo actionWithDuration:0.1f scale:originalScale];
        zoomAction.tag = kZoomActionTag;
        [self runAction:zoomAction];
    }
}


@end
