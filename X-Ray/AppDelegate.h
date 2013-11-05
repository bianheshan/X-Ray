//
//  AppDelegate.h
//  X-Ray
//
//  Created by bian on 10/29/13.
//  Copyright (c) 2013 Griffin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewFilterViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    ViewFilterViewController *rootViewController;
}

@property (strong, nonatomic) UIWindow *window;

@end
