#import "SiprocalsdkReactnativePlugin.h"
#import <DigitalReefSDK/DigitalReefSDK.h>
#import <UserNotifications/UserNotifications.h>
#import <Foundation/Foundation.h>
@implementation SiprocalsdkReactnativePlugin
RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(setSDKStatus:(BOOL) value){
        if(value){
                [DigitalReef.shared setUp];
        } else {
                NSLog(@"[DigitalReef] setUp");
        }
}

RCT_EXPORT_METHOD(requestPushPermission){
    NSLog(@"requestPushPermission");
        [DigitalReef.shared requestPushPermission];
}

RCT_EXPORT_METHOD(sendEventWithName:(NSString *) eventName){
        [DigitalReef sendEventWithName:eventName];
}

RCT_EXPORT_METHOD(createOrganisationFromCountryCode:(NSString *) countryCode){
        [DigitalReef.shared sendHostAppCountryCodeWithCc:countryCode];
}

RCT_EXPORT_METHOD(requestAppTrackingTransparencyPermission) {
    NSLog(@"requestAppTrackingTransparencyPermission");
        [DigitalReef.shared requestAppTrackingTransparencyPermission];
}

RCT_EXPORT_METHOD(setClientAttributes:(NSDictionary *) attributes){  
       [DigitalReef.shared setClientAttributesWithAttributes:attributes];
}

RCT_EXPORT_METHOD(updateOptInStatus:(BOOL) optIn){
        [DigitalReef.shared optInToEngagementAdsWithOptIn:optIn];
        [DigitalReef.shared optInToMonetizationAdsWithOptIn:optIn];
}

RCT_EXPORT_METHOD(getOptInStatus:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject){
 @try {
    BOOL optInStatus = [DigitalReef.shared getMonetizationAdsOptInStatus] && [DigitalReef.shared getEngagementAdsOptInStatus];
    resolve(@(optInStatus));
  } @catch (NSError *error) {
    reject(@"get_opt_in_status_error", @"There was an error getting the opt-in status", error);
  }
}

@end
