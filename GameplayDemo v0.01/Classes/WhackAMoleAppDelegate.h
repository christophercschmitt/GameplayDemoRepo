//
//  WhackAMoleAppDelegate.h
//  WhackAMole
//
//  Created by Ray Wenderlich on 1/5/11.
//  Copyright Ray Wenderlich 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

@class RootViewController;

@interface WhackAMoleAppDelegate : NSObject <UIAccelerometerDelegate, UIAlertViewDelegate, UITextFieldDelegate, UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
	//UITextField *myText;
	//UITextField *levelEntryTextField;
}

-(void)specificStartLevel;

@property (nonatomic, retain) UIWindow *window;

@end
