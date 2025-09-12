

#ifndef DigitalReefSDK_h
#define DigitalReefSDK_h
#import <DigitalReefSDK/DigitalReefSDK.h>
#import <UserNotifications/UNUserNotificationCenter.h>
#endif

#if __has_include(<React/RCTBridgeModule.h>)
#import "React/RCTBridgeModule.h"
#import "React/RCTEventEmitter.h"
#import "React/RCTLog.h"
#else
#import "RCTBridgeModule.h"
#import "RCTEventEmitter.h"
#import "RCTLog.h"
#import "RCTViewManager.h"
#import "RCTEventDispatcher.h"
#endif



#ifdef RCT_NEW_ARCH_ENABLED
#import "RNSiprocalsdkReactnativePluginSpec.h"
@interface SiprocalsdkReactnativePlugin : NSObject <NativeSiprocalsdkReactnativePluginSpec>
#else
#import <React/RCTBridgeModule.h>

@interface SiprocalsdkReactnativePlugin : NSObject <RCTBridgeModule>

+ (void)sendEventWithName:(NSString *)name withBody:(NSDictionary *)body;

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler;

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler;


#endif

@end
