//
//  AppDelegate.m
//  TalentC-Webp
//
//  Created by chuliangliang on 2017/4/6.
//  Copyright © 2017年 chuliangliang. All rights reserved.
//

#import "AppDelegate.h"
#import "RootVC.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor whiteColor];
    
    RootVC *rVC = [[RootVC alloc] initWithNibName:nil bundle:nil];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:rVC];
    return YES;
}

@end
