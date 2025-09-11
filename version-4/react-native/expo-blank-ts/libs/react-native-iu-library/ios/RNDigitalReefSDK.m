// Created by Bruno Guimarães on 23/03/22

#import "RNDigitalReefSDK.h"
#import <DigitalReefSDK/DigitalReefSDK.h>
#import <UserNotifications/UserNotifications.h>

@implementation RNDigitalReefSDK{

}

RCT_EXPORT_MODULE(IuLibraryModule);

-(instancetype)init {
    if (self = [super init]) {
        for (NSString *eventName in [self supportedEvents])
        [[NSNotificationCenter defaultCenter] addObserver: self selector:@selector(emitEvent:) name:eventName object:nil];
    }

    return self;
}

- (void) startObserving {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"bridgeSet" object:nil];
}
- (void) emitEvent:(NSNotification *)notification {
    [self sendEventWithName:notification.name body:notification.userInfo];
}
+ (void)sendEventWithName:(NSString *)name withBody:(NSDictionary *)body {
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil userInfo:body];
}

- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}

+(BOOL)requiresMainQueueSetup {
    return YES;
}

-(NSArray<NSString *> *)supportedEvents {
    return @[@"pushReceivedCallback", @"pushClickedCallback", @"pushTokenCallback", @"pushPermissionCallback", @"authorizationStatus"];
}

@synthesize bridge = _bridge;

RCT_EXPORT_METHOD(initiOS){
    dispatch_async(dispatch_get_main_queue(), ^{
        DigitalReef *digitalReef = DigitalReef.shared;
    });
}

RCT_EXPORT_METHOD(requestPushPermission){
    dispatch_async(dispatch_get_main_queue(), ^{
        [DigitalReef.shared requestPushPermission];
    });
}

RCT_EXPORT_METHOD(sendEventWithName:(NSString *) eventName){
    dispatch_async(dispatch_get_main_queue(), ^{
        [DigitalReef sendEventWithName:eventName];
    });
}

RCT_EXPORT_METHOD(createOrganisationFromCountryCode:(NSString *) countryCode){
    dispatch_async(dispatch_get_main_queue(), ^{
        [DigitalReef.shared sendHostAppCountryCodeWithCc:countryCode];
    });
}

RCT_EXPORT_METHOD(requestAppTrackingTransparencyPermission) {
    dispatch_async(dispatch_get_main_queue(), ^{
        [DigitalReef.shared requestAppTrackingTransparencyPermission];
    });
}

RCT_EXPORT_METHOD(setClientAttributes:(NSDictionary *) attributes){
   dispatch_async(dispatch_get_main_queue(), ^{
       [DigitalReef.shared setClientAttributesWithAttributes:attributes];
   });
}

RCT_EXPORT_METHOD(updateOptInStatusForEngagement:(BOOL) optIn){
    dispatch_async(dispatch_get_main_queue(), ^{
        [DigitalReef.shared optInToEngagementAdsWithOptIn:optIn];
    });
}

RCT_EXPORT_METHOD(updateOptInStatus:(BOOL) optIn){
    dispatch_async(dispatch_get_main_queue(), ^{
        [DigitalReef.shared optInToMonetizationAdsWithOptIn:optIn];
    });
}
RCT_EXPORT_METHOD(getOptInStatusForEngagement:(RCTResponseSenderBlock)callback){
    callback(@[[NSNumber numberWithBool:[DigitalReef.shared getEngagementAdsOptInStatus]]]);
}
RCT_EXPORT_METHOD(getOptInStatus:(RCTResponseSenderBlock)callback){
    callback(@[[NSNumber numberWithBool:[DigitalReef.shared getMonetizationAdsOptInStatus]]]);
}

RCT_EXPORT_METHOD(userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler) {
    dispatch_async(dispatch_get_main_queue(), ^{
        [DigitalReef.shared willPresentNotificationWithCenter:center willPresent:notification withCompletionHandler:completionHandler];
    });
}
RCT_EXPORT_METHOD(userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler) {
    dispatch_async(dispatch_get_main_queue(), ^{
        [DigitalReef.shared didReceiveNotificationResponseWithCenter:center didReceive:response withCompletionHandler:completionHandler];
    });
}
RCT_EXPORT_METHOD(application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler) {
    dispatch_async(dispatch_get_main_queue(), ^{
        [DigitalReef.shared didReceiveRemoteNotificationWithApplication:application userInfo:userInfo fetchCompletionHandler:completionHandler];
    });
}
RCT_EXPORT_METHOD(application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken) {
    dispatch_async(dispatch_get_main_queue(), ^{
        [DigitalReef.shared didRegisterForRemoteNotificationsWithDeviceToken:application deviceToken:deviceToken];
    });
}

@end
