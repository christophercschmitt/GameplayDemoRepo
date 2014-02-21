// When you import cocos2d.h, you import all the cocos2d classes
#import "cocos2d.h"
#import "CCEnemySprite.h"

// HelloWorld Layer
@interface HelloWorld : CCLayerColor //child of a CCLayerColor? i.e. inherits all propeties of a layer
{
	
}

// returns a Scene that contains the HelloWorld as the only child
+(id) scene;

@end
