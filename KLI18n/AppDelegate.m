//
//  AppDelegate.m
//  KLI18n
//
//  Created by klook on 2017/4/5.
//  Copyright © 2017年 klook. All rights reserved.
//

#import "AppDelegate.h"
#import "KLI18nUtil.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSArray *bundles = [NSBundle allBundles];
    for (NSBundle *bundle in bundles) {
        NSLog(@"bundle path: %@", bundle.resourcePath);
    }
    NSString *mainBundlePath = [NSBundle mainBundle].bundlePath;
    NSLog(@"main bundle path: %@", mainBundlePath);
    
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    NSLog( @"%@" , currentLanguage);
    
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* languages2 = [defs objectForKey:@"AppleLanguages"];
    NSString* preferredLang = [languages2 objectAtIndex:0];
    NSLog( @"%@" , preferredLang);
    
    NSLocale *currentLocale = [NSLocale currentLocale];
    NSLog(@"Country Code is %@", [currentLocale objectForKey:NSLocaleCountryCode]);
    NSLog(@"Language Code is %@", [currentLocale objectForKey:NSLocaleLanguageCode]);
    
    NSString *testString = [KLI18nUtil localizedString:@"hello"];
//    testString = [KLI18nUtil localizedString:@"hello1" defaultValue:@"teeee"];
    
    NSLog(@"test :: %@", testString);
    
//    NSArray *langs = [NSLocale availableLocaleIdentifiers];
//    NSLog(@"All Language: %@", langs);
    
    
    NSArray *i18ns = [KLI18nUtil shareI18nUtil].supportLocalizes;
    NSLog(@"All i18ns: %@", i18ns);
    
    
    NSArray *locales = [NSLocale availableLocaleIdentifiers];
    NSLog(@"Available Locales: %@", locales);
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
